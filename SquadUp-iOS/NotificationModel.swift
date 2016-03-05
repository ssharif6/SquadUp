//
//  NotificationModel.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/4/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import Foundation
import Firebase

class NotificationModel {
    private var _notificationString: String!
    private var _notificationType: String!
    private var _sentFrom: UserModel!
    private var _notificationKey: String!
    private var _sentFromID: String!
    
    var notificationString: String {
        return _notificationString
    }
    
    var notificationType: String {
        return _notificationType
    }
    
    var sentFrom: UserModel {
        let key = _sentFromID
        var user: UserModel!
        DataService.ds.REF_USERS.observeEventType(.Value, withBlock: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let userKey = snap.key
                        if(key == userKey) {
                            user = UserModel(userKey: userKey, dictionary: userDict)
                            print("Notification Person Found")
                        }
                    }
                }
            }
        })
        return user
    }
    
    init(notificationKey: String, dictionary: Dictionary<String, AnyObject>) {
        if let notificationString = dictionary["notificationMessage"] {
            _notificationString = notificationString as? String
        }
        if let notificationType = dictionary["notificationType"] {
            _notificationType = notificationType as? String
        }
        if let sentFromId = dictionary["sentFromID"] {
            _sentFromID = sentFromId as? String
        }
    }
    
    
    
}