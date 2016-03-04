//
//  RivalListViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/4/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class RivalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passedLabel: String!
    var passedImage: UIImage!
    
    var personToPass: UserModel!
    
    @IBOutlet weak var sportLabel: UILabel!
    
    var rivalList: [UserModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportLabel.text = "Choose a \(passedLabel) Rival"
    }
    
    func parseData() {
        // For now, we will just find people with similar sport interests and contain the sport passed in
        // TODO: Implement levl for each sport
        DataService.ds.REF_USERS.observeEventType(.Value, withBlock: {snapshot in
            self.rivalList = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let user = UserModel(userKey: key, dictionary: userDict)
                        if user.sports.contains(self.passedLabel) {
                            self.rivalList.append(user)
                        }
                    }
                }
            }
        })
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RivalCell") as! RivalListCell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // segue to individual
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RivalChosen" {
            
        }
    }
    
}
