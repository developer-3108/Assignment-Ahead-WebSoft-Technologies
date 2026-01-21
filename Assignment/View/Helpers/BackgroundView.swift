//
//  BackgroundView.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI
import UIKit

// MARK: - BackgroundView
/// Custom background color view
/// Uses light gray color (rgb(242, 243, 247)) as specified in design requirements
struct BackgroundView: View {
    var body: some View {
        // Light gray background color matching design specifications
        Color.init(red: 242/255, green: 243/255, blue: 247/255)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

// MARK: - View Extension
extension View {
    /// Convenience modifier to apply custom background view
    /// Wraps the view in a ZStack with BackgroundView behind it
    /// - Returns: Modified view with custom background
    func showBackgroundView() -> some View {
        ZStack {
            // Background view fills entire screen
            BackgroundView()
            
            // Content view sits on top of background
            self
        }
    }
}

//#Preview {
//    BackgroundView()
//}
