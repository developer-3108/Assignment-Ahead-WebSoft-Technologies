//
//  MenuScreen.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

/// Main menu screen displaying dynamic menu items in a two-column grid layout
/// Manages menu sections, collapsible "APPS" section, and action buttons
struct MenuScreen: View {
    
    // MARK: - Properties
    
    /// View model managing menu data and API communication
    /// Uses @StateObject to ensure single instance and proper lifecycle management
    @StateObject var dataViewModel = DataViewModel()
    
    /// State variable controlling whether "APPS" section is expanded
    /// When false, only shows first 4 items with "See More" button
    @State private var isAppsExpanded = false
    
    /// Grid column configuration for two-column layout
    /// Both columns are flexible to adapt to screen size
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: - Header Section
                // Header bar with menu title, language selector, and search icon
                headerBar
                
                // MARK: - Profile Section
                // User profile display with profile image, name, and edit button
                UserProfile()
                
                // MARK: - Menu Sections
                // Dynamically generated sections from API data
                ForEach(dataViewModel.groupedSections) { section in
                    VStack(alignment: .leading, spacing: 10) {
                        
                        // Section title (e.g., "APPS", "HELP & MORE")
                        if let title = section.title {
                            Text(title.capitalized)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        // Determine items to show based on collapsible state
                        // APPS section shows only 4 items initially if not expanded
                        let itemsToShow = (section.isCollapsible && !isAppsExpanded) ? Array(section.items.prefix(4)) : section.items
                        
                        // Two-column grid layout for menu items
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(Array(itemsToShow.enumerated()), id: \.element.id) { index, item in
                                ContentBoxView(imageURL: item.icon, title: item.label)
                            }
                        }
                        
                        // "See More" button for collapsible sections that are not expanded
                        if section.isCollapsible && !isAppsExpanded {
                            Button {
                                // Expand section to show all items
                                isAppsExpanded = true
                            } label: {
                                SeeMoreButton
                            }
                        }
                        
                    }
                }
                .padding(.horizontal)
                
                // MARK: - Action Buttons
                // Rate Us and Sign Out buttons extracted from API data
                // These are displayed separately at the bottom
                VStack(spacing: 12) {
                    ForEach(dataViewModel.actionButtons) { menu in
                        ActionButtonView(menu: menu)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 50)
        }
        // Apply custom background color
        .showBackgroundView()
        // Fetch menu data when view appears
        .onAppear {
            Task {
                await dataViewModel.fetchData()
            }
        }
    }
}
