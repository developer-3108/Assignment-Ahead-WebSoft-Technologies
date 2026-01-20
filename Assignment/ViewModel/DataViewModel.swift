//
//  DataViewModel.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import Foundation
import Combine

class DataViewModel: ObservableObject {
    @Published var dataModel: DataModel? = nil
    @Published var apiURL: String  = "https://demo.socialnetworking.solutions/sesapi/navigation?restApi=\(restApi)&sesapi_platform=\(sesapi_platform)&auth_token=\(authtoken)"
    
    private let maxRetries: Int = 3
    private let retryDelay: TimeInterval = 2.0
    
    func fetchData(retryCount: Int = 0) async {
        
        startLoadingAnimation()
        
        debugLog(message: "Starting to fetch the API data", type: .info)
        
        guard let url = URL(string: apiURL) else {
            debugLog(message: "Failed to get API URL", type: .failed)
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(DataModel.self, from: data)
            await MainActor.run {
                self.dataModel = decodedResponse
            }
            debugLog(message: "API Data: \(String(describing: self.dataModel))", type: .debug)
            debugLog(message: "API Data fetched successfully", type: .success)
            
            stopLoadingAnimation()
            
        } catch {
            
            stopLoadingAnimation()
            
            debugLog(message: "Failed to fetch the API data: \(error.localizedDescription)", type: .failed)
            
            if retryCount < maxRetries {
                debugLog(message: "Retrying... Attempt \(retryCount + 1) of \(maxRetries)", type: .info)
                try? await Task.sleep(nanoseconds: UInt64(retryDelay * 1_000_000_000))
                await fetchData(retryCount: retryCount + 1)
            } else {
                debugLog(message: "Max retry attempts reached. Giving up.", type: .failed)
            }
        }
    }
}

extension DataViewModel {
    var groupedSections: [MenuSection] {
        guard let rawMenus = dataModel?.result.menus else { return [] }
        
        var sections: [MenuSection] = []
        var currentItems: [Menu] = []
        var currentHeader: String? = nil
        
        for menu in rawMenus {
            if menu.type == 0 {
                if !currentItems.isEmpty {
                    
                    let isApps = (currentHeader == "APPS")
                    sections.append(MenuSection(title: currentHeader, items: currentItems, isCollapsible: isApps))
                }
                
                currentHeader = menu.label
                currentItems = []
                
            } else {
                currentItems.append(menu)
            }
        }
        
        if !currentItems.isEmpty {
            let isApps = (currentHeader == "APPS")
            sections.append(MenuSection(title: currentHeader, items: currentItems, isCollapsible: isApps))
        }
        
        return sections
    }
}
