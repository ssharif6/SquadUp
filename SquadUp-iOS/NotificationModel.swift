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
    private var _sportChallenge: String!
    var user: UserModel!

    
    var notificationString: String {
        return _notificationString
    }
    
    var notificationType: String {
        return _notificationType
    }
    
    var sentFromId: String {
        return _sentFromID
    }
    
    var sportChallenge: String {
        return _sportChallenge
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
        if let sportChallenge = dictionary["sportChallenge"] {
            _sportChallenge = sportChallenge as? String
        }
    }
    
    
    
}