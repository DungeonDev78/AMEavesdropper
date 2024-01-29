//
//  SessionLogsVM.swift
//  
//
//  Created by Alessandro Manilii on 29/01/24.
//

import Foundation

class SessionLogsVM {
    
    private var items = [LogModel]()
    private var selectedItems = [LogModel]()
    
    init() {
        items = Eavesdropper.getLogs()
    }
    
}
