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
    private var _created: NSDate!
    
    var messageBody: String {
        return _messageBody
    }
    
    var sentFrom: String {
        return _sentFrom
    }
    
    var created: NSDate {
        return _created
    }
    
    init(messageKey: String, dictionary: Dictionary<String, AnyObject>) {
        if let messageBody = dictionary["messageBody"] {
            _messageBody = messageBody as! String
        }
        if let sentFrom = dictionary["sentFrom"] {
            _sentFrom = sentFrom as! String
        }
        if let created = dictionary["created"] {
            _created = created as! NSDate
        }
    }
}