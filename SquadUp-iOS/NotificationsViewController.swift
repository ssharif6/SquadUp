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

    override func viewDidLoad() {
        super.viewDidLoad()
        parseNotificationData()
    }
    
    func parseNotificationData() {
        var asdf = [NotificationModel]()
        DataService.ds.REF_USER_CURRENT.childByAppendingPath("notifications").observeEventType(.Value, withBlock: { snapshot in
            asdf = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let notificationDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let notification: NotificationModel = NotificationModel(notificationKey: key, dictionary: notificationDict)
                        asdf.append(notification)
                    }
                }
            }
            self.notifications = asdf
            self.notificationTableView.reloadData()
        })
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
