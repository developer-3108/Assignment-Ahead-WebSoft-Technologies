//
//  MenuScreen+Header.swift
//  Assignment
//
//  Created by Akshat Srivastava on 21/01/26.
//

import SwiftUI

// MARK: - MenuScreen Header Extension
/// Extension containing header bar UI components
/// Separated from main MenuScreen for better code organization
extension MenuScreen {
    
    // MARK: - Header Bar
    
    /// Main header bar with menu title, language selector, and search icon
    var headerBar: some View {
        HStack {
            // Menu title
            Text("Menu")
                .foregroundStyle(.primary)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            // Language selector button
            languageSelector
            
            // Search icon button
            searchIcon
        }
        .padding(.horizontal)
    }
    
    // MARK: - Header Components
    
    /// Language selector component showing country, currency, and language
    /// Displays with globe icon and dropdown chevron
    var languageSelector: some View {
        HStack {
            Image(systemName: "globe.fill")
                
            Text("IND-INR-EN")
            
            Image(systemName: "chevron.down")
        }
        .font(.callout)
        .foregroundStyle(.black)
        .padding(10)
        .background(Capsule().fill(Color(.systemGray5)))
    }
    
    /// Search icon button with circular background
    /// Uses system gray background for visual consistency
    var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .padding(10)
            .background(Circle().fill(Color(.systemGray5)))
            .font(.callout)
            .fontWeight(.bold)
            .foregroundStyle(.black)
    }
}
