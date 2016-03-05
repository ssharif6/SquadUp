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
    @IBOutlet weak var rivalTableView: UITableView!
    
    var rivalList = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportLabel.text = "Choose a \(passedLabel) Rival"
        parseData()
    }
    
    func parseData() {
        // For now, we will just find people with similar sport interests and contain the sport passed in
        // TODO: Implement levl for each sport
        var asdf = [UserModel]()
        DataService.ds.REF_USERS.observeEventType(.Value, withBlock: { snapshot in
            asdf = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let user = UserModel(userKey: key, dictionary: userDict)
                        print(user.firstName)
                        print(user.sports)
                        if user.sports.contains(self.passedLabel) {
                            print("WOOT")
                            asdf.append(user)
                        }
                    }
                }
            }
            self.rivalList = asdf
            self.rivalTableView.reloadData()
        })
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RivalCell") as! RivalListCell
        cell.configureCell(rivalList[indexPath.row])
        print(self.rivalList[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rivalList.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.personToPass = rivalList[indexPath.row]
        print(self.personToPass.firstName)
        performSegueWithIdentifier("RivalChosen", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RivalChosen" {
            let vc = segue.destinationViewController as! RivalScreenViewController
            vc.personPassed = self.personToPass
        }
    }
    
}
