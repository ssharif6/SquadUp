//
//  RivalScreenViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/4/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class RivalScreenViewController: UIViewController {
    
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var currentUserProfilePic: UIImageView!
    @IBOutlet weak var rivalProfilePic: UIImageView!
    var personPassed: UserModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        challengeNameLabel.text = "Challenge \(personPassed.firstName)"
        challengeNameLabel.textAlignment = .Center
        let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
        let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
        
        let urlCurrent = NSURL(string: userUnarchived.profileImageURL)
        if userUnarchived.profileImageURL == "" {
            currentUserProfilePic.image = UIImage(named: "defaultProfile")
        } else {
            let data = NSData(contentsOfURL:urlCurrent!)
            if data != nil {
                currentUserProfilePic.image = UIImage(data:data!)
                currentUserProfilePic.contentMode = UIViewContentMode.ScaleAspectFit
                
            }
        }
        let urlRival = NSURL(string: personPassed.profileImageURL)
        if personPassed.profileImageURL == "" {
            rivalProfilePic.image = UIImage(named: "defaultProfile")
        } else {
            let data = NSData(contentsOfURL: urlRival!)
            if data != nil {
                rivalProfilePic.image = UIImage(data: data!)
                rivalProfilePic.contentMode = UIViewContentMode.ScaleAspectFit
            }
        }

        currentUserProfilePic.layer.borderColor = UIColor.blackColor().CGColor
        currentUserProfilePic.layer.cornerRadius = currentUserProfilePic.frame.height / 2
        currentUserProfilePic.clipsToBounds = true
        
        rivalProfilePic.layer.borderColor = UIColor.blackColor().CGColor
        rivalProfilePic.layer.cornerRadius = rivalProfilePic.frame.height / 2
        rivalProfilePic.clipsToBounds = true
        
        let currentUserProfPicCenter = currentUserProfilePic.center
        let rivalProfilePicCenter = rivalProfilePic.center
        
        currentUserProfilePic.center.y = self.view.frame.height - 100
        rivalProfilePic.center.y = self.view.frame.height + 100
        currentUserProfilePic.alpha = 0
        rivalProfilePic.alpha = 0
        
        UIView.animateWithDuration(1.5, delay: 1, usingSpringWithDamping: 0.6, initialSpringVelocity: 6.0, options: UIViewAnimationOptions.CurveLinear, animations: ({
            self.currentUserProfilePic.alpha = 1
            self.rivalProfilePic.alpha = 1
            self.currentUserProfilePic.center.y = currentUserProfPicCenter.y
            self.rivalProfilePic.center.y = rivalProfilePicCenter.y
            
        }), completion: nil)
        
    }
    @IBAction func ChallengeButtonPressed(sender: AnyObject) {
        
    }

    
}
