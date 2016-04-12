//
//  MoreSettingsTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/5/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MoreSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var settingImage: UIImageView!
    let facebookLogin = FBSDKLoginManager()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(label: String) {
        if(label == "Edit Profile") {
            settingImage.image = UIImage(named: "moreEditProfileIcon")
        } else if label == "Notifications" {
            settingImage.image = UIImage(named: "moreNotificationIcon")
        } else if label == "Create Lobby" {
            settingImage.image = UIImage(named: "moreCreateLobbyIcon")
        } else if label == "Join Lobby" {
            settingImage.image = UIImage(named: "moreJoinLobbyIcon")
        } else if label == "Rate Us" {
            settingImage.image = UIImage(named: "filledStar-1")
        } else if label == "Log Out" {
            settingImage.image = UIImage(named: "moreLogoutIcon")
            

        }
        settingLabel.text = label
        settingLabel.textAlignment = .Left
    }

    
}
