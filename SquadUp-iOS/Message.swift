//
//  Message.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/18/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import Foundation

class Message {
    
    private var _messageBody: String!
    private var _sentFrom: String! // User's Guid
    private var _created: String!
    
    var messageBody: String {
        return _messageBody
    }
    
    var sentFrom: String {
        return _sentFrom
    }
    
    var created: String {
        return _created
    }
    
    init(messageKey: String, dictionary: Dictionary<String, AnyObject>) {
        if let messageBody = dictionary["messageBody"] {
            _messageBody = messageBody as! String
        }
        if let sentFrom = dictionary["sentFromID"] {
            _sentFrom = sentFrom as! String
        }
        if let created = dictionary["dateCreated"] {
            _created = created as! String
        }
    }
}