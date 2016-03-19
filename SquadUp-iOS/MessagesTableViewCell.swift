//
//  MessagesTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/18/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message) {
        let text = message.messageBody
        messageLabel.text = text
    }


}
