//
//  DataViewModel.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import Foundation
import Combine

/// ViewModel for managing menu data and API communication
/// Handles fetching, retrying, and transforming menu data from the API
/// Follows MVVM pattern with ObservableObject for reactive updates
class DataViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Observable menu data model - nil until API call succeeds
    /// UI automatically updates when this property changes
    @Published var dataModel: DataModel? = nil
    
    // MARK: - API Configuration
    
    /// Dynamically constructed API URL using constants from Secrets.swift
    /// Includes restApi, sesapi_platform, and authtoken as query parameters
    let apiURL: String = "https://demo.socialnetworking.solutions/sesapi/navigation?restApi=\(restApi)&sesapi_platform=\(sesapi_platform)&auth_token=\(authtoken)"
    
    // MARK: - Retry Configuration
    
    /// Maximum number of retry attempts for failed API calls
    private let maxRetries: Int = 3
    
    /// Delay in seconds between retry attempts
    private let retryDelay: TimeInterval = 2.0
    
    // MARK: - API Methods
    
    /// Fetches menu data from the API with automatic retry mechanism
    /// - Parameter retryCount: Current retry attempt (default: 0)
    /// - Note: Automatically retries up to maxRetries times with retryDelay between attempts
    func fetchData(retryCount: Int = 0) async {
        // Start loading animation to show user that API call is in progress
        startLoadingAnimation()
        
        debugLog(message: "Starting to fetch the API data", type: .info)
        
        // Validate API URL before making the request
        guard !apiURL.isEmpty, let url = URL(string: apiURL) else {
            debugLog(message: "Failed to get API URL", type: .failed)
            stopLoadingAnimation()
            return
        }
        
        do {
            // Make async network request to fetch data
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode JSON response into DataModel structure
            let decodedResponse = try JSONDecoder().decode(DataModel.self, from: data)
            
            // Update published property on main thread for UI updates
            await MainActor.run {
                self.dataModel = decodedResponse
            }
            
            debugLog(message: "API Data: \(String(describing: self.dataModel))", type: .debug)
            debugLog(message: "API Data fetched successfully", type: .success)
            
            // Stop loading animation after successful fetch
            stopLoadingAnimation()
            
        } catch {
            // Stop loading animation even on error
            stopLoadingAnimation()
            
            debugLog(message: "Failed to fetch the API data: \(error.localizedDescription)", type: .failed)
            
            // Retry logic: attempt retry if we haven't reached max retries
            if retryCount < maxRetries {
                debugLog(message: "Retrying... Attempt \(retryCount + 1) of \(maxRetries)", type: .info)
                // Wait for retryDelay before attempting again
                try? await Task.sleep(nanoseconds: UInt64(retryDelay * 1_000_000_000))
                // Recursively call fetchData with incremented retry count
                await fetchData(retryCount: retryCount + 1)
            } else {
                debugLog(message: "Max retry attempts reached. Giving up.", type: .failed)
            }
        }
    }
}

// MARK: - Data Transformation Extension
extension DataViewModel {
    
    /// Transforms flat menu array into organized sections
    /// Filters out action buttons (Rate Us, Sign Out) and groups items by section headers
    /// - Returns: Array of MenuSection objects ready for display
    /// - Note: "APPS" section is marked as collapsible
    var groupedSections: [MenuSection] {
        // Safely unwrap menus array, return empty array if nil
        guard let rawMenus = dataModel?.result.menus else { return [] }
        
        // Filter out action buttons - these are displayed separately
        let regularMenus = rawMenus.filter { menu in
            menu.class != "core_main_sesapi_rate" && menu.class != "core_mini_auth"
        }
        
        // Variables to track current section being built
        var sections: [MenuSection] = []
        var currentItems: [Menu] = []
        var currentHeader: String? = nil
        
        // Iterate through menu items and group them by section headers
        for menu in regularMenus {
            if menu.type == 0 {
                // Type 0 = Section header
                // Save previous section if it has items
                if !currentItems.isEmpty {
                    // Check if current header is "APPS" to mark as collapsible
                    let isApps = (currentHeader == "APPS")
                    sections.append(MenuSection(title: currentHeader, items: currentItems, isCollapsible: isApps))
                }
                
                // Start new section with this header
                currentHeader = menu.label
                currentItems = []
                
            } else {
                // Type 1 = Regular menu item, add to current section
                currentItems.append(menu)
            }
        }
        
        // Add final section if there are remaining items
        if !currentItems.isEmpty {
            let isApps = (currentHeader == "APPS")
            sections.append(MenuSection(title: currentHeader, items: currentItems, isCollapsible: isApps))
        }
        
        return sections
    }
    
    /// Extracts action buttons (Rate Us and Sign Out) from menu array
    /// These buttons are displayed separately at the bottom of the screen
    /// - Returns: Array of Menu items with class "core_main_sesapi_rate" or "core_mini_auth"
    var actionButtons: [Menu] {
        // Safely unwrap menus array, return empty array if nil
        guard let rawMenus = dataModel?.result.menus else { return [] }
        
        // Filter for action button items
        return rawMenus.filter { menu in
            menu.class == "core_main_sesapi_rate" || menu.class == "core_mini_auth"
        }
    }
}
