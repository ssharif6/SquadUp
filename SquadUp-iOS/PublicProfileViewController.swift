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
    @IBOutlet weak var requestRivalButton: UIButton!
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
                        print("WaterMonkeys")
                        if key == self.userPassed {
                            let user = UserModel(userKey: key, dictionary: userDict)
                            print("NIGGA")
                            asdf = user
                        }
                    }
                }
            }
            self.user = asdf
            self.loadData()
        })
        
    }
    
    func loadData() {
        profileName.text = self.user.firstName + " " + self.user.lastName
        let url = NSURL(string: imageUrlPassed)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            profileImage.image = UIImage(data:data!)
        }
    }
    
}
