//
//  ViewController.swift
//  
//
//  Created by Alessandro Manilii on 29/01/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    var logsView: LogsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log List"

        logsView = LogsView(logs: Eavesdropper.getLogs())
        
        logsView?.injectIn(view: mainView)
        // Do any additional setup after loading the view.
    }
    


}
