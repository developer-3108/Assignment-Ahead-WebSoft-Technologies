//
//  AssignmentApp.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

/// App entry point - Initializes the SwiftUI application
/// This is the main struct that serves as the entry point for the app
/// It creates a WindowGroup containing the ContentView
@main
struct AssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            // ContentView serves as the root view container with loading overlay support
            ContentView()
        }
    }
}
