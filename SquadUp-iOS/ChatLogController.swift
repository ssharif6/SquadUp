//
//  ChatLogController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 4/10/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var messagesArray:[Message] = [Message]()
    var userPassed: UserModel!
    
    var rival: UserModel? {
        didSet {
            navigationItem.title = (rival?.firstName)! + " " + (rival?.lastName)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(ChatLogCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
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
        
        cell.messageTextView.frame = CGRectMake(48 + 8, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
        cell.textBubbleView.frame = CGRectMake(48, 0, estimatedFrame.width + 16 + 15, estimatedFrame.height + 15)
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

}

    