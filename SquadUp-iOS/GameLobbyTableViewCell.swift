//
//  GameLobbyTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/6/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Cosmos

class GameLobbyTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cosmosContainer: UIView!
    @IBOutlet weak var cosmosView: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(user: UserModel, fromRecentActivity: Bool) {
        nameLabel.text = user.firstName + " " + user.lastName
        var rating = cosmosView.rating
        if fromRecentActivity == false {
            cosmosContainer.hidden = true
        }
        let url = NSURL(string: user.profileImageURL)
        if user.profileImageURL == "" {
            profileImage.image = UIImage(named: "defaultProfile")
        } else {
            let data = NSData(contentsOfURL: url!)
            if data != nil {
                profileImage.image = UIImage(data: data!)
                profileImage.contentMode = UIViewContentMode.ScaleAspectFit
            }
        }
//        let urlCurrent = NSURL(string: userUnarchived.profileImageURL)
//        if userUnarchived.profileImageURL == "" {
//            currentUserProfilePic.image = UIImage(named: "defaultProfile")
//        } else {
//            let data = NSData(contentsOfURL:urlCurrent!)
//            if data != nil {
//                currentUserProfilePic.image = UIImage(data:data!)
//                currentUserProfilePic.contentMode = UIViewContentMode.ScaleAspectFit
//                
//            }
//        }

    }

}
