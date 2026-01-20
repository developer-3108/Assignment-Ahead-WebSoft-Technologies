//
//  Helper.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import Foundation

enum LogType: String {
    case success = "✅ Success"
    case failed = "❌ Failed"
    case debug = "👉 Debug"
    case warning = "⚠️ Warning"
    case action = "⚡️ Action"
    case info = "ℹ️ Info"
}

func debugLog(message: String, type: LogType = .debug) {
    #if DEBUG
    print("\(type.rawValue): \(message)")
    #endif
}
