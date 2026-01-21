//
//  Helper.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import Foundation

// MARK: - LogType
/// Enumeration of log types for categorizing debug messages
/// Each case has an emoji prefix for easy visual identification in console
enum LogType: String {
    case success = "✅ Success"
    case failed = "❌ Failed"
    case debug = "👉 Debug"
    case warning = "⚠️ Warning"
    case action = "⚡️ Action"
    case info = "ℹ️ Info"
}

// MARK: - Debug Logging
/// Debug logging function that only prints in DEBUG builds
/// This helps with development debugging without cluttering production builds
/// - Parameters:
///   - message: The log message to display
///   - type: The type of log (default: .debug)
func debugLog(message: String, type: LogType = .debug) {
    #if DEBUG
    print("\(type.rawValue): \(message)")
    #endif
}
