//
//  DataModel.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import Foundation

// MARK: - DataModel
/// Root response model from the API
/// Contains the result object and session identifier
struct DataModel: Decodable {
    let result: Result
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case sessionId = "session_id"
    }
}

// MARK: - Result
/// Contains the menus array and metadata from the API response
struct Result: Decodable {
    let menus: [Menu]
    let notificationCount: Int
    let friendReqCount: Int
    let messageCount: Int
    let loggedinUserId: Int
    
    enum CodingKeys: String, CodingKey {
        case menus
        case notificationCount = "notification_count"
        case friendReqCount = "friend_req_count"
        case messageCount = "message_count"
        case loggedinUserId = "loggedin_user_id"
    }
}

// MARK: - Menu
/// Individual menu item from the API response
/// Conforms to Identifiable for use in ForEach loops
/// Type 0 = Section header, Type 1 = Regular menu item
struct Menu: Decodable, Identifiable {
    let type: Int
    let module: String?
    let label: String
    let icon: String
    let url: String
    let `class`: String
    
    /// Unique identifier combining label, icon, and class
    /// This ensures uniqueness even if multiple items have the same label
    var id: String {
        // Combine multiple fields to ensure uniqueness
        return "\(label)-\(icon)-\(`class`)"
    }
}

// MARK: - MenuSection
/// Grouped menu sections for display
/// Created from flat menu array by grouping items under section headers
struct MenuSection: Identifiable {
    let id = UUID()
    let title: String?
    let items: [Menu]
    /// True only for "APPS" section to enable collapsible functionality
    var isCollapsible: Bool 
}
