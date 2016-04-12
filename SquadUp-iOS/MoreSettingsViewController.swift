//
//  MoreSettingsViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/5/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import FBSDKLoginKit


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
        if indexPath.row == 5 {
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: KEY_UID)
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: SELECTED_SPORTS)
            facebookLogin.logOut()
            let LoginVCOBJ = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("ViewControllerId") as! ViewController
            self.navigationController?.viewControllers = [LoginVCOBJ]
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }

}
