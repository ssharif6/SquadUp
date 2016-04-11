//
//  ChatViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/17/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var messagesArray:[Message] = [Message]()
    var userPassed: UserModel!
    
    @IBOutlet weak var dockViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messagesTextField: UITextField!
    @IBOutlet weak var messagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messagesTextField.delegate = self
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.tableViewTapped))
        self.messagesTableView.addGestureRecognizer(tapGesture)
        downloadChatHistory()
        self.messagesTableView.rowHeight = 80
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
    }

    
    func downloadChatHistory() {
        messagesArray.removeAll()
        DataService.ds.REF_USER_CURRENT.childByAppendingPath("messages").childByAppendingPath(userPassed.userKey).childByAppendingPath("messages").observeEventType(.Value, withBlock: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let messageDict = snap.value as? Dictionary<String, AnyObject> {
                        let message = Message(messageKey: snap.key, dictionary: messageDict)
                        self.messagesArray.append(message)
                    }
                    
                }
            }
            self.messagesTableView.reloadData()
        })
    }

    @IBAction func sendButtonTapped(sender: UIButton) {
        // perform animation to grow the dock view
        self.messagesTextField.endEditing(true)
        // Post to firebase
        self.messagesArray.removeAll()
        let messagePost = DataService.ds.REF_USER_CURRENT.childByAppendingPath("messages").childByAppendingPath(userPassed.userKey).childByAppendingPath("messages").childByAutoId()
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
        let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
        let sentUserMessagePost = DataService.ds.REF_USERS.childByAppendingPath(userPassed.userKey).childByAppendingPath("messages").childByAppendingPath(userUnarchived.userKey).childByAppendingPath("messages").childByAutoId()

        let message: Dictionary<String, AnyObject> = [
            "dateCreated": timestamp,
            "messageBody": messagesTextField.text!,
            "sentFromID": userUnarchived.userKey
        ]
        messagePost.setValue(message)
        sentUserMessagePost.setValue(message)
    }
    
    func tableViewTapped() {
        self.messagesTextField.endEditing(true)
    }
    
    // MARK: Textfield Delegate Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.3, animations: {
            self.dockViewHeightConstraint.constant = 300
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.4, animations: {
            self.dockViewHeightConstraint.constant = 60
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    // MARK: TableView Delegate Methods
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Do something
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessagesTableViewCell
        let message = messagesArray[indexPath.row]
        cell.messageLabel.numberOfLines = 0
        cell.configureCell(message)
        return cell
    }

}
