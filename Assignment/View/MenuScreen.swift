//
//  MenuScreen.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

struct MenuScreen: View {
    
    @StateObject var dataViewModel = DataViewModel()
    @State private var isAppsExpanded = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                headerBar
                
                UserProfile()
                
                ForEach(dataViewModel.groupedSections) { section in
                    VStack(alignment: .leading, spacing: 10) {
                        
                        if let title = section.title {
                            Text(title.capitalized)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        let itemsToShow = (section.isCollapsible && !isAppsExpanded) ? Array(section.items.prefix(4)) : section.items
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(Array(itemsToShow.enumerated()), id: \.element.id) { index, item in
                                ContentBoxView(imageURL: item.icon, title: item.label)
                            }
                        }
                        
                        if section.isCollapsible && !isAppsExpanded {
                            Button {
                                    isAppsExpanded = true
                            } label: {
                                SeeMoreButton
                            }
                        }
                        
                    }
                }
                .padding(.horizontal)
                
                SignOutButton
                    .padding(.horizontal)
            }
            .padding(.bottom, 50)
        }
        .showBackgroundView()
        .onAppear {
            Task {
                await dataViewModel.fetchData()
            }
        }
    }
}
