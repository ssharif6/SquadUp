//
//  NotificaionTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/4/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class NotificaionTableViewCell: UITableViewCell {
    @IBOutlet weak var displayedImage: UIImageView!
    @IBOutlet weak var notificationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(notification: NotificationModel) {
        notificationLabel.text = notification.notificationString
    }


}
