//
//  LoadingAnimationHelper.swift
//  Assignment
//
//  Created by Akshat Srivastava on 21/01/26.
//

import Foundation
import Combine

class LoadingAnimationHelper: ObservableObject {
    static let shared = LoadingAnimationHelper()
    
    @Published var isLoading = false
    
    private init() {
        
    }
}

@MainActor
func startLoadingAnimation() {
    debugLog(message: "Starting to load loading animation", type: .warning)
    let isLoading = true
    LoadingAnimationHelper.shared.isLoading = isLoading
    debugLog(message: "isLoading value set to \(LoadingAnimationHelper.shared.isLoading)", type: .success)
}

@MainActor
func stopLoadingAnimation() {
    debugLog(message: "Stopping loading animation", type: .warning)
    let isLoading = false
    LoadingAnimationHelper.shared.isLoading = isLoading
    debugLog(message: "isLoading value set to \(LoadingAnimationHelper.shared.isLoading)", type: .success)
}

