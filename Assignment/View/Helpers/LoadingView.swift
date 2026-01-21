//
//  LoadingView.swift
//  Assignment
//
//  Created by Akshat Srivastava on 21/01/26.
//

import SwiftUI

// MARK: - LoadingView
/// Loading overlay component shown during API calls
/// Displays semi-transparent black overlay with centered progress indicator
struct LoadingView: View {
    var body: some View {
        ZStack {
            // Semi-transparent black overlay to dim background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            // Centered circular progress indicator
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                .scaleEffect(1.5)
        }
    }
}

// MARK: - View Extension
extension View {
    /// Convenience modifier to show/hide loading overlay
    /// Disables user interaction when loading is active
    /// - Parameter isLoading: Boolean flag to control loading overlay visibility
    /// - Returns: Modified view with conditional loading overlay
    func showLoadingView(_ isLoading: Bool) -> some View {
        ZStack {
            // Main content view - disabled during loading to prevent interaction
            self
                .disabled(isLoading)
            
            // Show loading overlay when isLoading is true
            if isLoading {
                LoadingView()
            }
        }
    }
}
