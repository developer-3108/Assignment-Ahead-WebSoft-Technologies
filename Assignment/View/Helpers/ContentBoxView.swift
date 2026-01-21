//
//  ContentBoxView.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

/// Reusable menu item card component
/// Displays menu item icon and title in a white card with shadow
/// Used in the two-column grid layout for menu items
struct ContentBoxView: View {
    
    // MARK: - Properties
    
    /// URL string for the menu item icon image
    let imageURL: String
    
    /// Title/label text for the menu item
    let title: String
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Async image loading from URL
            // Shows loading indicator while image loads
            if let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                } placeholder: {
                    // Loading indicator shown while image is being fetched
                    ProgressView()
                }
            }
            
            // Menu item title text
            Text(title)
                .foregroundStyle(.black)
                .font(.subheadline)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 80)
        // White card background with subtle shadow for elevation effect
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 1)
        )
    }
}

//#Preview {
//    ContentBoxView()
//}
