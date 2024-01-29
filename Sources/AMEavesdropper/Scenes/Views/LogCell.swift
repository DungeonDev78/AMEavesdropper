//
//  LogCell.swift
//  Postepay Business
//
//  Created by Alessandro Manilii on 25/01/24.
//  Copyright © 2024 Poste Italiane SPA. All rights reserved.
//

import UIKit

class LogCell: UITableViewCell {
    
    @IBOutlet weak var lblMsg: UILabel!
    private var log: LogModel?

    func configureWith(log: LogModel) {
        self.log = log
        lblMsg.text = log.message
    }

}
