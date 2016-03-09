//
//  RivalsTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/8/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class RivalsTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.blackColor().CGColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true

    }
    
    func configureCell(user: UserModel) {
        self.nameLabel.text = user.firstName + " " + user.lastName
        let url = NSURL(string: user.profileImageURL)
        if user.profileImageURL == "" {
            profileImage.image = UIImage(named: "defaultProfile")
        } else {
            let data = NSData(contentsOfURL:url!)
            if data != nil {
                profileImage.image = UIImage(data:data!)
                profileImage.contentMode = UIViewContentMode.ScaleAspectFit
                
            }
        }
    }
}
