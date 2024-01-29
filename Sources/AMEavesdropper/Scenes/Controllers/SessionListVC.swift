//
//  SessionListVC.swift
//  Postepay Business
//
//  Created by Alessandro Manilii on 25/01/24.
//  Copyright © 2024 Poste Italiane SPA. All rights reserved.
//

import UIKit
import SwiftUI

final class SessionListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension SessionListVC {
    
    static func presentController() {
//        let storyboard = UIStoryboard(name: "Eavesdropper", bundle: Bundle.module)
//        let sessionListVC = storyboard.instantiateViewController(
//            withIdentifier: "ViewController"
//        ) as! ViewController
//
//        let navController = UINavigationController(rootViewController: sessionListVC)
        let topVC = UIViewController.topMostViewController()
//        topVC?.present(navController, animated: true)
        let swiftUIView = LogsView(logs: Eavesdropper.getLogs())
        let viewCtrl = UIHostingController(rootView: swiftUIView)
        
        topVC?.present(viewCtrl, animated: true)
        

    }
}
