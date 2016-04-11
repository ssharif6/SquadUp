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
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
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
            self.collectionView!.reloadData()
        })
    }

}

    