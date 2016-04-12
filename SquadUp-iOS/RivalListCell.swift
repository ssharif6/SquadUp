//
//  RivalListCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/4/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class RivalListCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var numStarsLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.blackColor().CGColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
    func configureCell(user: UserModel) {
        // figure out rating data here
        let url = NSURL(string: user.profileImageURL)
        if let image = imageCache.objectForKey(user.profileImageURL) as? UIImage {
            self.profileImage.image = image
        } else {
            if user.profileImageURL == "" {
                profileImage.image = UIImage(named: "defaultProfile")
            } else {
                let data = NSData(contentsOfURL:url!)
                if data != nil {
                    profileImage.image = UIImage(data:data!)
                    profileImage.contentMode = UIViewContentMode.ScaleAspectFit
                }
                imageCache.setObject(UIImage(data: data!)!, forKey: user.profileImageURL)
            }
        }
        
        
        nameLabel.text = user.firstName + " " + user.lastName
        let rating = user.rating
        numStarsLabel.text = String(rating)
    }
    
    func configureRating(rating: Int) {
        
    }


    
}
