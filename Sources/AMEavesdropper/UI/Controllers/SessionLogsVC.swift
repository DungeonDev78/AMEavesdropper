//
//  SessionLogsVC.swift
//  Postepay Business
//
//  Created by Alessandro Manilii on 25/01/24.
//  Copyright © 2024 Poste Italiane SPA. All rights reserved.
//

import UIKit

class SessionLogsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
}

extension SessionLogsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Eavesdropper.logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = Eavesdropper.logs[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LogCell", for: indexPath
        ) as? LogCell
        
        cell?.configureWith(log: item)
        return cell ?? UITableViewCell()
    }
}

private extension SessionLogsVC {
    
    func setupVC() {
        title = "SESSION LOGS"
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action, target: self, action: #selector(shareTapped)
        )
    }
    
    @objc func shareTapped() {
        let items = [Eavesdropper.createTextualLog()]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}
