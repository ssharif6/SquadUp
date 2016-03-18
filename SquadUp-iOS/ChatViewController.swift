//
//  ChatViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/17/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var messagesArray:[String] = [String]()
    var userPassed: UserModel!
    
    @IBOutlet weak var dockViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messagesTextField: UITextField!
    @IBOutlet weak var messagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messagesTextField.delegate = self
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tableViewTapped")
        self.messagesTableView.addGestureRecognizer(tapGesture)
    }

    @IBAction func sendButtonTapped(sender: UIButton) {
        // perform animation to grow the dock view
        self.messagesTextField.endEditing(true)
        // Post to firebase
    }
    
    func tableViewTapped() {
        self.messagesTextField.endEditing(true)
    }
    
    func downloadMessages() {
        // get all the data from firebase
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Do something
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell")
        return cell!
    }

}
