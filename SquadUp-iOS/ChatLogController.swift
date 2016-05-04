//
//  ChatLogController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 4/10/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
    
    private let cellId = "cellId"
    
    var messagesArray:[Message] = [Message]()
    var userPassed: UserModel!
    var bottomConstraint: NSLayoutConstraint?
    var rival: UserModel? {
        didSet {
            navigationItem.title = (rival?.firstName)! + " " + (rival?.lastName)!
        }
    }
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
    let sendButton: UIButton = {
       let button = UIButton(type: .System)
        button.setTitle("Send", forState: .Normal)
        let titleColor = UIColor.rgb(0, green: 137, blue: 249)
        button.setTitleColor(titleColor, forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        return button
    }()
    
    let inputTextField: UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "Enter Message..."
        return textfield
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.hidden = true
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(ChatLogCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        view.addSubview(messageInputContainerView)
        view.addConstraintsWithFormat("H:|[v0]|", view: messageInputContainerView)
        view.addConstraintsWithFormat("V:[v0(48)]", view: messageInputContainerView)
        
        // constant contains cooridnate of y coords
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(bottomConstraint!)
        
        setupInputComponenets()
        downloadChatHistory()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleKeyboardNotification), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleKeyboardNotification), name: UIKeyboardWillHideNotification, object: nil)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), forControlEvents: .TouchUpInside)

    }
    
    func sendButtonTapped() {
        // perform animation to grow the dock view
        self.inputTextField.endEditing(true)
        // Post to firebase
        self.messagesArray.removeAll()
        let messagePost = DataService.ds.REF_USER_CURRENT.childByAppendingPath("messages").childByAppendingPath(userPassed.userKey).childByAutoId()
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
        let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
        let sentUserMessagePost = DataService.ds.REF_USERS.childByAppendingPath(userPassed.userKey).childByAppendingPath("messages").childByAppendingPath(userUnarchived.userKey).childByAppendingPath("messages").childByAutoId()
        
        let message: Dictionary<String, AnyObject> = [
            "dateCreated": timestamp,
            "messageBody": inputTextField.text!,
            "sentFromID": userUnarchived.userKey,
            "isSender": false,
            "messageId": "TestId"
        ]
        messagePost.setValue(message)
        sentUserMessagePost.setValue(message)
        self.inputTextField.text = ""
    }
    
    func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
            let isKeyboardShowing = notification.name == UIKeyboardWillShowNotification
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
                self.view.layoutIfNeeded()
                }, completion: { (completed) in
                    if isKeyboardShowing {
                        if self.messagesArray.count > 0 {
                            let indexPath = NSIndexPath(forItem: self.messagesArray.count - 1, inSection: 0)
                            self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                        }
                    }
            })
        }
    }
    
    private func setupInputComponenets() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(topBorderView)
        
        messageInputContainerView.addConstraintsWithFormat("H:|-8-[v0][v1(60)]|", view: inputTextField, sendButton)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0]|", view: inputTextField)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0]|", view: sendButton)

        messageInputContainerView.addConstraintsWithFormat("H:|[v0]|", view: topBorderView)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0(0.5)]", view: topBorderView)

    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ChatLogCollectionViewCell
        cell.messageTextView.text = self.messagesArray[indexPath.item].messageBody
        if(self.messagesArray[indexPath.item].isSender) {
            let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
            let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
            let urlRival = NSURL(string: userUnarchived.profileImageURL)
            if userUnarchived.profileImageURL == "" {
                cell.profileImageView.image = UIImage(named: "defaultProfile")
            } else {
                let data = NSData(contentsOfURL: urlRival!)
                if data != nil {
                    cell.profileImageView.image = UIImage(data: data!)
                }
            }
        } else {
            let urlRival = NSURL(string: userPassed.profileImageURL)
            if userPassed.profileImageURL == "" {
                cell.profileImageView.image = UIImage(named: "defaultProfile")
            } else {
                let data = NSData(contentsOfURL: urlRival!)
                if data != nil {
                    cell.profileImageView.image = UIImage(data: data!)
                }
            }
        }

        
        let messageText = messagesArray[indexPath.item].messageBody
        let size = CGSizeMake(250, 1000)
        let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
        
        if self.messagesArray[indexPath.item].isSender.boolValue {
            cell.messageTextView.frame = CGRectMake(48 + 8, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRectMake(48, 0, estimatedFrame.width + 16 + 15, estimatedFrame.height + 15)
            cell.profileImageView.hidden = false
        } else {
            cell.profileImageView.hidden = true
            cell.textBubbleView.backgroundColor = UIColor.rgb(230, green: 230, blue: 230)
            cell.messageTextView.textColor = UIColor.blackColor()
            cell.messageTextView.frame = CGRectMake(view.frame.width - estimatedFrame.width - 16 - 16, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRectMake(view.frame.width - estimatedFrame.width - 16 - 8 - 16, 0, estimatedFrame.width + 16 + 15, estimatedFrame.height + 15)
        }
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        inputTextField.endEditing(true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let messageText = messagesArray[indexPath.item].messageBody
        let size = CGSizeMake(250, 750)
        let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
        
        
        return CGSizeMake(view.frame.width, estimatedFrame.height + 20)
    }
    
    
    
    func downloadChatHistory() {
        messagesArray.removeAll()
        DataService.ds.REF_USER_CURRENT.childByAppendingPath("messages").childByAppendingPath(userPassed.userKey).observeEventType(.Value, withBlock: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let messageDict = snap.value as? Dictionary<String, AnyObject> {
                        let message = Message(messageKey: snap.key, dictionary: messageDict)
                        self.messagesArray.append(message)
                    }
                }
            }
            self.collectionView!.reloadData()
        })
    }
    
}
