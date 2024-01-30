//
//  UIWindow+Extension.swift
//  Postepay Business
//
//  Created by Alessandro Manilii on 25/01/24.
//  Copyright © 2024 Poste Italiane SPA. All rights reserved.
//

import UIKit

extension UIWindow {
    
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        super.motionEnded(motion, with: event)
        if EavesdropperManager.shared.shakeToPresentLogs {
            if motion == .motionShake {
                EavesdropperManager.shared.presentSessionList()
            }
        }
    }
}
