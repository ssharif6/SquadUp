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
    
    var rival: UserModel? {
        didSet {
            navigationItem.title = (rival?.firstName)! + " " + (rival?.lastName)!
        }
    }
    
    let textTextView: UITextView = {
        let textView = UITextView()
    
        
        textView.text = "TEST"
        let size = CGSizeMake(250, 1000)
        let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
        let estimatedFrame = NSString(string: textView.text).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
        textView.frame = CGRectMake(8, UIScreen.mainScreen().bounds.size.height - 80, UIScreen.mainScreen().bounds.size.width, estimatedFrame.height + 40)
        textView.scrollEnabled = false
        return textView
    }()
    
    func textViewDidChange(textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max - 100))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max - 100))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(ChatLogCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        setupViews()
        downloadChatHistory()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ChatLogCollectionViewCell
        cell.messageTextView.text = self.messagesArray[indexPath.item].messageBody
        
        cell.profileImageView.image = UIImage(named: "Steph")
        
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let messageText = messagesArray[indexPath.item].messageBody
        let size = CGSizeMake(250, 750)
        let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
        
        
        return CGSizeMake(view.frame.width, estimatedFrame.height + 20)
    }
    
    func downloadChatHistory() {
        messagesArray.removeAll()
        DataService.ds.REF_USER_CURRENT.childByAppendingPath("messages").observeEventType(.Value, withBlock: { snapshot in
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
    
    func setupViews() {
        self.view.addSubview(textTextView)
        
        // Constraints
        
    }

}
