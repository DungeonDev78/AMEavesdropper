//
//  LogModel.swift
//  Postepay Business
//
//  Created by Alessandro Manilii on 25/01/24.
//  Copyright © 2024 Poste Italiane SPA. All rights reserved.
//

import Foundation

class LogModel: Codable, Identifiable {
    
    let message: String?
    let date: Date?
    let sessionID: UUID?
    let id: UUID
    
    init(message: String?, sessionID: UUID?) {
        self.message = message
        self.date = Date()
        self.sessionID = sessionID
        self.id = UUID()
    }
}

extension LogModel {
    static var examples: [LogModel] {
        let sessionID = UUID()
        return [
            LogModel(message: "AppDelegate: UIResponder, UIApplicationDelegate", sessionID: sessionID),
            LogModel(message: "ViewController: ViewDidLoad Completed", sessionID: sessionID),
            LogModel(message: "User Logged In", sessionID: sessionID),
            LogModel(message: "Data Loaded from Database", sessionID: sessionID),
            LogModel(message: "Error: Network Unreachable", sessionID: sessionID),
            LogModel(message: "User Profile Updated", sessionID: sessionID),
            LogModel(message: "Checkout Process Started", sessionID: sessionID),
            LogModel(message: "Payment Successful", sessionID: sessionID),
            LogModel(message: "Logout Completed", sessionID: sessionID),
            LogModel(message: "App Entered Background", sessionID: sessionID),
            LogModel(message: "App Entered Foreground", sessionID: sessionID),
            LogModel(message: "Received Push Notification", sessionID: sessionID),
            LogModel(message: "User Reached Level 5", sessionID: sessionID),
            LogModel(message: "Settings Changed", sessionID: sessionID),
            LogModel(message: "New Content Available", sessionID: sessionID),
            LogModel(message: "{\"event\": \"User Completed Tutorial\", \"status\": \"success\"}", sessionID: sessionID),
            LogModel(message: "{\"event\": \"Database Migration Started\", \"progress\": \"0%\"}", sessionID: sessionID),
            LogModel(message: "{\"event\": \"Database Migration Completed\", \"progress\": \"100%\"}", sessionID: sessionID),
            LogModel(message: "{\"user\": \"New User Registered\", \"id\": \"12345\"}", sessionID: sessionID),
            LogModel(message: "{\"system\": \"Shutdown Initiated\", \"timestamp\": \"2023-01-01T12:00:00Z\"}", sessionID: sessionID)
        ]
    }
}
