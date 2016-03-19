//
//  NotificaionTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/4/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class NotificaionTableViewCell: UITableViewCell {
    @IBOutlet weak var displayedImage: UIImageView!
    @IBOutlet weak var notificationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(notification: NotificationModel) {
        notificationLabel.text = notification.notificationString
        getUserData(notification)
    }
    
    func getUserData(notification: NotificationModel) {

        DataService.ds.REF_USERS.observeEventType(.Value, withBlock: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        print(snap.key)
                        if(notification.sentFromId == snap.key) {
                            let user = UserModel(userKey: snap.key, dictionary: userDict)
                            print("Notification Person Found")
                            let userUrl = NSURL(string: user.profileImageURL)
                            if user.profileImageURL == "" {
                                self.displayedImage.image = UIImage(named: "defaultProfile")
                            } else {
                                if let image = imageCache.objectForKey(user.profileImageURL) as? UIImage {
                                    self.displayedImage.image = image
                                } else {
                                    let data = NSData(contentsOfURL: userUrl!)
                                    if data != nil {
                                        self.displayedImage.image = UIImage(data: data!)
                                        self.displayedImage.contentMode = UIViewContentMode.ScaleAspectFit
                                        imageCache.setObject(UIImage(data: data!)!, forKey: user.profileImageURL)
                                    }
                                }
                                
                            }

                        }
                    }
                }
            }
        })

    }


}
