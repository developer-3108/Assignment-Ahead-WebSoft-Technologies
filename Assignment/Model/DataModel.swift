//
//  DataModel.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import Foundation

struct DataModel: Decodable {
    let result: Result
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case sessionId = "session_id"
    }
}

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

struct Menu: Decodable, Identifiable {
    let type: Int
    let module: String?
    let label: String
    let icon: String
    let url: String
    let `class`: String
    
    var id: String {
        // Combine multiple fields to ensure uniqueness
        return "\(label)-\(icon)-\(`class`)"
    }
}

struct MenuSection: Identifiable {
    let id = UUID()
    let title: String?
    let items: [Menu]
    var isCollapsible: Bool 
}
