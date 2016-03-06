//
//  MoreSettingsViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/5/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class MoreSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var moreSettingsTableView: UITableView!
    
    var settingsArray = ["Edit Profile", "Notifications", "Create Lobby", "Join Lobby", "Rate Us", "Log Out"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MoreSettingCell") as! MoreSettingsTableViewCell
        cell.configureCell(settingsArray[indexPath.row])
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }

}
