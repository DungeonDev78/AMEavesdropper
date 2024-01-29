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
    @IBOutlet weak var lblSelectedCount: UILabel!
    @IBOutlet weak var cnstTableToBottom: NSLayoutConstraint!
    
    private var items = [LogModel]()
    private var selectedItems = [LogModel]()
    private var tableViewHandler: SessionLogTVH?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    @IBAction func deleteSelectedBtnTapped(_ sender: UIButton) {
        selectedItems = []
        updateSelectionArea()
    }
}

// MARK: - UITableViewDelegate
extension SessionLogsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        toggle(item: item)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        toggle(item: item)
    }
}

private extension SessionLogsVC {
    
    func setupVC() {
        title = "SESSION LOGS"
        items = Eavesdropper.getLogs()
        tableView.delegate = self
        tableViewHandler = SessionLogTVH(tableView: tableView) { [weak self] action in
            switch action {
            case .updateSelection: self?.updateSelectionArea()
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action, target: self, action: #selector(shareTapped)
        )
    }
    
    @objc func shareTapped() {
        let items = [Eavesdropper.createTextualLog()]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    func toggle(item: LogModel) {
        if let index = selectedItems.firstIndex(where: { $0.id == item.id }) {
            selectedItems.remove(at: index)
        } else {
            selectedItems.append(item)
            selectedItems = selectedItems
                .sorted { $0.date ?? Date() < $1.date ?? Date() }
        }
        
        updateSelectionArea()
    }
    
    func updateSelectionArea() {
        
        lblSelectedCount.text = "Selected items: \(selectedItems.count)"
        
        if selectedItems.isEmpty {
            cnstTableToBottom.constant = -40
        } else {
            cnstTableToBottom.constant = 60
        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}
