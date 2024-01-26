//
//  LogModel.swift
//  Postepay Business
//
//  Created by Alessandro Manilii on 25/01/24.
//  Copyright © 2024 Poste Italiane SPA. All rights reserved.
//

import Foundation

class LogModel: Codable {
    
    let message: String?
    let date: Date?
    let sessionID: UUID?
    
    init(message: String?, sessionID: UUID?) {
        self.message = message
        self.date = Date()
        self.sessionID = sessionID
    }
}
