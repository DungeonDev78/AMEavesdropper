//
//  SessionLogTVH.swift
//
//  Created by Alessandro Manilii on 29/01/24.
//

import UIKit

class SessionLogTVH: NSObject {
    
    enum ActionType {
        case updateSelection
    }
    
    private var tableView: UITableView
    private var onAction: (ActionType) -> Void
    private var items = [LogModel]()
    private var selectedItems = [LogModel]()
    
    
    init(tableView: UITableView, onAction: @escaping (ActionType) -> Void) {
        self.tableView = tableView
        self.onAction = onAction
        super.init()
        self.tableView.dataSource = self
    }
}

extension SessionLogTVH: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LogCell", for: indexPath
        ) as? LogCell
        
        cell?.configureWith(log: item)
        return cell ?? UITableViewCell()
    }
}

private extension SessionLogTVH {
    
    func toggle(item: LogModel) {
        if let index = selectedItems.firstIndex(where: { $0.id == item.id }) {
            selectedItems.remove(at: index)
        } else {
            selectedItems.append(item)
            selectedItems = selectedItems
                .sorted { $0.date ?? Date() < $1.date ?? Date() }
        }
        
        onAction(.updateSelection)
    }
}
