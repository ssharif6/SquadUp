//
//  RivalsMessagesViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/8/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class RivalsMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var idArray = [UserModel]()
    @IBOutlet weak var rivalsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        rivalsTableView.dataSource = self
        rivalsTableView.delegate = self
        parseData()
    }
    func parseData() {
        var asdf = [UserModel]()
        DataService.ds.REF_USER_CURRENT.childByAppendingPath("rivals").observeEventType(.Value, withBlock: { snapshot in
            asdf = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        print(key)
                        let user = UserModel(userKey: key, dictionary: userDict)
                        asdf.append(user)
                    }
                }
            }
            self.idArray = asdf
            self.rivalsTableView.reloadData()
        })
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RivalCell")
        cell?.textLabel?.text = idArray[indexPath.row].firstName
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
}
