//
//  LoadingAnimationHelper.swift
//  Assignment
//
//  Created by Akshat Srivastava on 21/01/26.
//

import Foundation
import Combine

// MARK: - LoadingAnimationHelper
/// Singleton class for managing global loading state across the app
/// Uses ObservableObject pattern to notify views of loading state changes
/// This allows any view to react to loading state changes
class LoadingAnimationHelper: ObservableObject {
    /// Shared singleton instance - ensures single source of truth for loading state
    static let shared = LoadingAnimationHelper()
    
    /// Published property that triggers UI updates when loading state changes
    /// ContentView observes this to show/hide loading overlay
    @Published var isLoading = false
    
    /// Private initializer ensures only one instance exists (singleton pattern)
    private init() {
        
    }
}

// MARK: - Loading State Functions

/// Starts the loading animation by setting isLoading to true
/// Marked with @MainActor to ensure thread-safe UI updates
/// Used before starting async operations like API calls
@MainActor
func startLoadingAnimation() {
    debugLog(message: "Starting to load loading animation", type: .warning)
    let isLoading = true
    LoadingAnimationHelper.shared.isLoading = isLoading
    debugLog(message: "isLoading value set to \(LoadingAnimationHelper.shared.isLoading)", type: .success)
}

/// Stops the loading animation by setting isLoading to false
/// Marked with @MainActor to ensure thread-safe UI updates
/// Used after completing async operations like API calls
@MainActor
func stopLoadingAnimation() {
    debugLog(message: "Stopping loading animation", type: .warning)
    let isLoading = false
    LoadingAnimationHelper.shared.isLoading = isLoading
    debugLog(message: "isLoading value set to \(LoadingAnimationHelper.shared.isLoading)", type: .success)
}

