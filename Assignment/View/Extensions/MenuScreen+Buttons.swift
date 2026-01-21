//
//  MenuScreen+Buttons.swift
//  Assignment
//
//  Created by Akshat Srivastava on 21/01/26.
//

import Foundation
import SwiftUI

// MARK: - MenuScreen Buttons Extension
/// Extension containing button components and action button styling
/// Separated from main MenuScreen for better code organization
extension MenuScreen {
    
    // MARK: - See More Button
    
    /// "See More" button for expanding collapsible sections
    /// Gray background button shown when section has more items to display
    var SeeMoreButton: some View {
        Text("See More")
            .foregroundStyle(.black)
            .font(.subheadline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).fill(Color(.systemGray5)))
    }
    
    // MARK: - Action Button View
    
    /// Dynamic button styling based on menu item class
    /// Handles two types of action buttons from API:
    /// - Rate Us: White background with shadow, icon and text
    /// - Sign Out: Red border, red text, transparent background
    /// - Parameter menu: Menu item containing button information
    /// - Returns: Styled button view based on menu class
    @ViewBuilder
    func ActionButtonView(menu: Menu) -> some View {
        // Rate Us button - white background with shadow
        if menu.class == "core_main_sesapi_rate" {
            
            HStack {
                // Icon image loaded asynchronously from URL
                if let url = URL(string: menu.icon) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                    } placeholder: {
                        // Loading indicator while icon loads
                        ProgressView()
                    }
                }
                
                // Button label text
                Text(menu.label)
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding(7)
            // White card background with shadow for elevation
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(.white))
                    .shadow(color: .black.opacity(0.2), radius: 1)
            )
            
        // Sign Out button - red border with transparent background
        } else if menu.class == "core_mini_auth" {
            
            Text(menu.label)
                .foregroundStyle(.red)
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .padding(7)
                // Red border only, no fill background
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.red, lineWidth: 1)
                )
        }
    }
}
