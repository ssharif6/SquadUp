//
//  PublicProfileViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/20/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class PublicProfileViewController: UIViewController {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var recentHistoryButton: UIButton!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var oneStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    var userPassed: String!
    var imageUrlPassed: String!
    var user: UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var asdf: UserModel!
        DataService.ds.REF_USERS.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            // Parse Firebase Data
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    print("SNAP \(snap)")
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        print(key)
                        if key == self.userPassed {
                            let user = UserModel(userKey: key, dictionary: userDict)
                            self.user = user
                            asdf = user
                        }
                    }
                }
            }
            self.user = asdf
            self.loadData()
        })
    }
    
    @IBOutlet weak var friendButton: UIButton!
    @IBAction func addFriendPressed(sender: AnyObject) {
        // post to firebase
        let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
        let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
        
        let key = userUnarchived.userKey
        let name = userUnarchived.firstName + " " + userUnarchived.lastName
        let notification: Dictionary<String, AnyObject> = [
            "notificationMessage": "\(name) has sent a Friend Request!",
            "notificationType": "friendRequest",
            "sentFromId": String(key)
        ]
        let notificationPost = DataService.ds.REF_USERS.childByAppendingPath(self.user.userKey).childByAppendingPath("notifications").childByAutoId()
        notificationPost.setValue(notification)
        friendButton.enabled = false
    }
    
    @IBAction func morePressed(sender: AnyObject) {
        let optionsMenu = UIAlertController(title: "More Information", message: "Choose Option", preferredStyle: .ActionSheet)
        let sendRequestAction = UIAlertAction(title: "Request Friend", style: .Default) { (alert) -> Void in
            let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
            let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
            
            let key = userUnarchived.userKey
            let name = userUnarchived.firstName + " " + userUnarchived.lastName
            let notification: Dictionary<String, AnyObject> = [
                "notificationMessage": "\(name) has sent a Friend Request!",
                "notificationType": "friendRequest",
                "sentFromId": String(key)
            ]
            let notificationPost = DataService.ds.REF_USERS.childByAppendingPath(self.user.userKey).childByAppendingPath("notifications").childByAutoId()
            notificationPost.setValue(notification)
            self.friendButton.enabled = false
        }
        let blockAction = UIAlertAction(title: "Block User", style: .Destructive, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        optionsMenu.addAction(sendRequestAction)
        optionsMenu.addAction(blockAction)
        optionsMenu.addAction(cancelAction)
        self.presentViewController(optionsMenu, animated: true, completion: nil)
    }
    
    func loadData() {
        profileName.text = self.user.firstName + " " + self.user.lastName
        let url = NSURL(string: imageUrlPassed)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            profileImage.image = UIImage(data:data!)
        }
    }
    @IBAction func recentActivityPressed(sender: AnyObject) {
        performSegueWithIdentifier("PublicRecentActivity", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PublicRecentActivity" {
            let vc = segue.destinationViewController as! PublicRecentActivityViewController
            vc.userPassed = self.user
        }
    }
    
}
