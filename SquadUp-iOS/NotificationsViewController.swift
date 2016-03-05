//
//  NotificationsViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/4/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notificationTableView: UITableView!
    
    var notifications = [NotificationModel]()
    var notificationArray = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        parseNotificationData()
    }
    
    func parseNotificationData() {
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NotificationCell") as! NotificaionTableViewCell
        cell.configureCell(notifications[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

}
