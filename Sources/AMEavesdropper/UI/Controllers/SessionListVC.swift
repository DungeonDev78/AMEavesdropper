//
//  SessionListVC.swift
//  Postepay Business
//
//  Created by Alessandro Manilii on 25/01/24.
//  Copyright © 2024 Poste Italiane SPA. All rights reserved.
//

import UIKit

final class SessionListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension SessionListVC {
    
    static func presentController() {
        let storyboard = UIStoryboard(name: "Eavesdropper", bundle: Bundle.module)
        let sessionListVC = storyboard.instantiateViewController(
            withIdentifier: "SessionLogsVC"
        ) as! SessionLogsVC
        
        let navController = UINavigationController(rootViewController: sessionListVC)
        let topVC = UIViewController.topMostViewController()
        topVC?.present(navController, animated: true)
    }
}
