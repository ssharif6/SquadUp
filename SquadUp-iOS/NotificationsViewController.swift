//
//  NotificationsViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/4/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notificationTableView: UITableView!
    
    var notifications = [NotificationModel]()
    var notificationDeletedIndexPath: NSIndexPath? = nil
    var notificationToPass: NotificationModel!
    var index: Int!
    var didLoadAlready: String!
    static var imageCache = NSCache()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseNotificationData()
        
    }
    
    func parseNotificationData() {
        if didLoadAlready != "Loaded" {
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
    }
    
    func cancelDeletedNotification(alertAction: UIAlertAction!) {
        notificationDeletedIndexPath = nil
    }
    
    func confirmDelete(notification: NotificationModel) {
        let alert = UIAlertController(title: "Delete Notification", message: "Are you sure you want to permanently delete this notification?", preferredStyle: .ActionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeletedNotifications)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeletedNotification)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeletedNotifications(alertAction: UIAlertAction!) -> Void {
        if let indexPath = notificationDeletedIndexPath {
            notificationTableView.beginUpdates()
            notifications.removeAtIndex(indexPath.row)
            notificationTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.notificationDeletedIndexPath = nil
            notificationTableView.endUpdates()
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let optionMenu = UIAlertController(title: "Delete Notification", message: "Are you sure you want to delete this notification?", preferredStyle: .ActionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                self.notifications.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                var notificationsDict = [Dictionary<String, AnyObject>]()
                for (var i = 0; i < self.notifications.count; i++) {
                    let note = self.notifications[i]
                    let notification: Dictionary<String, AnyObject> = [
                        "notificationMessage": "\(note.notificationString)",
                        "notificationType": "\(note.notificationType)",
                        "sentFromID": "\(note.sentFromId)"
                    ]
                    notificationsDict.append(notification)
                }
                DataService.ds.REF_USER_CURRENT.childByAppendingPath("notifications").setValue(notificationsDict)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NotificationCell") as! NotificaionTableViewCell
        cell.configureCell(notifications[indexPath.row])

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let notification = notifications[indexPath.row]
        self.notificationToPass = notification
        self.index = indexPath.row
        self.didLoadAlready = "Loaded"
        performSegueWithIdentifier("ChallengeNotification", sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChallengeNotification" {
            let vc = segue.destinationViewController as! ChallengeOptionsViewController
            vc.notificationPassed = self.notificationToPass
            vc.passedIndex = self.index
            vc.passedNotificationsArray = self.notifications
            vc.didNotificationsLoad = self.didLoadAlready
        }
    }
    
}
