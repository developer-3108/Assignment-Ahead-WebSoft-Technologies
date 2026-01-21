//
//  ContentView.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

/// Root view container that wraps the main MenuScreen
/// Manages global loading state and applies loading overlay when needed
struct ContentView: View {
    // MARK: - Properties
    
    /// Observes the global loading state singleton
    /// This allows the view to react to loading state changes across the app
    @StateObject private var showLoadingAnimation = LoadingAnimationHelper.shared
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            // Main menu screen with all menu items and sections
            MenuScreen()
        }
        // Applies loading overlay when isLoading is true
        // This overlay blocks user interaction during API calls
        .showLoadingView(showLoadingAnimation.isLoading)
    }
}

