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
        let log01 = LogModel(message: "AppDelegate: UIResponder, UIApplicationDelegate", sessionID: sessionID)
        let log02 = LogModel(message: "It seems like you're missing a particular simulator version. I faced this error before. I've installed two XCode versions:", sessionID: sessionID)
        let log03 = LogModel(message: "Response: {\"Success\"}", sessionID: sessionID)
        let log04 = LogModel(message: "Primo log per prova", sessionID: sessionID)
        let log05 = LogModel(message: "You can also use the localized case insensitive comparison between two strings function and it returns Bool", sessionID: sessionID)
        return [log01, log02, log03, log04, log05]
    }
}
