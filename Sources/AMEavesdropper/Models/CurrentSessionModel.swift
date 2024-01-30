//
//  CurrentSessionModel.swift
//
//  Created by Alessandro Manilii on 25/01/24.
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
