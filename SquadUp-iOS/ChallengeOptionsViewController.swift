//
//  ChallengeOptionsViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/8/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class ChallengeOptionsViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sportImage: UIImageView!
    var notificationPassed: NotificationModel!
    var passedIndex: Int!
    var passedNotificationsArray = [NotificationModel]()
    var didNotificationsLoad: String!
    var user: UserModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        if notificationPassed.notificationType == "friendRequest" {
            headerLabel.text = "You have a friend request from"
        } else if notificationPassed.notificationType == "Challenge" {
            headerLabel.text = "You have been Challenged By"
            sportImage.image = UIImage(named: notificationPassed.sportChallenge)
            sportImage.layer.borderColor = UIColor.blackColor().CGColor
            sportImage.layer.cornerRadius = sportImage.frame.height / 2
            sportImage.clipsToBounds = true
        }
        profileImage.layer.borderColor = UIColor.blackColor().CGColor
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        

        // Do any additional setup after loading the view.
    }
    func parseData() {
        let challenger = notificationPassed.sentFromId
        DataService.ds.REF_USERS.observeEventType(.Value, withBlock: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        print(snap.key)
                        if(challenger == snap.key) {
                            let user = UserModel(userKey: snap.key, dictionary: userDict)
                            self.user = user
                            print("Notification Person Found")
                            self.nameLabel.text = user.firstName + " " + user.lastName
                            let userUrl = NSURL(string: user.profileImageURL)
                            if user.profileImageURL == "" {
                                self.profileImage.image = UIImage(named: "defaultProfile")
                            } else {
                                let data = NSData(contentsOfURL: userUrl!)
                                if data != nil {
                                    self.profileImage.image = UIImage(data: data!)
                                    self.profileImage.contentMode = UIViewContentMode.ScaleAspectFit
                                }
                            }
                            
                        }
                    }
                }
            }
        })
    }
    
    
    @IBAction func CheckmarkClicked(sender: AnyObject) {
        DataService.ds.REF_USER_CURRENT.childByAppendingPath("rivals").observeEventType(.Value, withBlock: { snapshot in
            let userToUse: Dictionary<String, AnyObject>
            = [
                "provider": self.user.provider, "id": self.user._userId, "rating": self.user.rating, "gender": self.user.gender, "firstName": self.user.firstName,"lastName": self.user.lastName, "posts": self.user.posts,"profileImageUrl": self.user.profileImageURL, "notifications": self.user.notifications, "recentActivity": self.user.recentActivity, "rivals": self.user.rivals
            ]
            DataService.ds.REF_USER_CURRENT.childByAppendingPath("rivals").setValue(userToUse)
        })
    }

    @IBAction func xmarkChecked(sender: AnyObject) {
        self.passedNotificationsArray.removeAtIndex(passedIndex)
        
        performSegueWithIdentifier("OptionsToNotifications", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "OptionsToNotifications" {
            let vc = segue.destinationViewController as! NotificationsViewController
            vc.notifications = self.passedNotificationsArray
            vc.didLoadAlready = "Loaded"
        }
    }
    

}
