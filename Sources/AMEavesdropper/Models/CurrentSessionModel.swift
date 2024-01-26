//
//  CurrentSessionModel.swift
//  Postepay Business
//
//  Created by Alessandro Manilii on 25/01/24.
//  Copyright © 2024 Poste Italiane SPA. All rights reserved.
//

import Foundation

class CurrentSessionModel: Codable {
    
    let date: Date?
    let sessionID: UUID?
    
    init() {
        self.date = Date()
        self.sessionID = UUID()
    }
}
