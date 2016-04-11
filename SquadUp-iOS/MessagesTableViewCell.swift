//
//  MessagesTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/18/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileIMage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var testImageUrl: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageLabel.numberOfLines = 0

    }
    
    func configureCell(message: Message) {
        let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
        let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
        let text = message.messageBody
        let senderId = message.sentFrom
        // Query to get the user's profile Image
        
        messageLabel.text = text
        
    }
    
    
}
