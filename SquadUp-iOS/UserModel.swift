//
//  UserModel.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/3/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserModel: NSObject {
    internal var _userId: String!
    private var _firstName: String!
    private var _lastName: String!
    private var _gender: String!
    private var _posts: [String]!
    private var _sports: [String]!
    private var _userKey: String!
    private var _provider: String!
    private var _fullName: String!
    private var _profileImageURL: String!
    private var _rating: String!
    private var _notifications: [NotificationModel]!
    private var _recentActivity: [String]!
    private var _rivals: [String]!
    private var _messages: [String]!
    
    var firstName: String {
        return _firstName
    }
    
    var messages: [String] {
        return _messages
    }
    
    var rivals: [String] {
        return _rivals
    }
    
    var recentActivity: [String] {
        return _recentActivity
    }
    
    var rating: String {
        return _rating
    }
    
    var notifications: [NotificationModel] {
        return _notifications
    }
    
    var profileImageURL: String {
        return _profileImageURL
    }
    
    var provider: String {
        return _provider
    }
    
    var lastName: String {
        return _lastName
    }
    
    var gender: String {
        return _gender
    }
    
    var posts: [String] {
        return _posts
    }
    
    var sports: [String] {
        return _sports
    }
    
    var userKey: String {
        return _userKey
    }
    
    init(key: String, firstName: String, lastName: String, gender: String, userId: String, posts: [String], sports: [String], rating: String, profileImageUrl: String, recentActivity: [String], rivals: [String], messages: [String]) {
        _firstName = firstName
        _lastName = lastName
        _gender = gender
        _userId = userId
        _posts = posts
        _sports = sports
        _userKey = key
        _rating = rating
        _profileImageURL = profileImageUrl
        _recentActivity = recentActivity
        _rivals = rivals
        _messages = messages
    }
    
    required init(coder decoder: NSCoder) {
        self._firstName = decoder.decodeObjectForKey("firstName") as! String
        self._lastName = decoder.decodeObjectForKey("lastName") as! String
        self._gender = decoder.decodeObjectForKey("gender") as! String
        _userId = decoder.decodeObjectForKey("userId") as? String
        _posts = decoder.decodeObjectForKey("posts") as? [String]
        _sports = decoder.decodeObjectForKey("Sports") as? [String]
        _userKey = decoder.decodeObjectForKey("userKey") as? String
        _profileImageURL = decoder.decodeObjectForKey("profileImageKey") as? String
        _rating = decoder.decodeObjectForKey("ratingKey") as? String
        _recentActivity = decoder.decodeObjectForKey("recentActivityKey") as? [String]
        _rivals = decoder.decodeObjectForKey("rivalsKey") as? [String]
        _messages = decoder.decodeObjectForKey("messagesKey") as? [String]
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(_firstName, forKey: "firstName")
        aCoder.encodeObject(_lastName, forKey: "lastName")
        aCoder.encodeObject(_gender, forKey: "gender")
        aCoder.encodeObject(_posts, forKey: "posts")
        aCoder.encodeObject(_sports, forKey: "Sports")
        aCoder.encodeObject(_userKey, forKey: "userKey")
        aCoder.encodeObject(_profileImageURL, forKey: "profileImageKey")
        aCoder.encodeObject(_rating, forKey: "ratingKey")
        aCoder.encodeObject(_recentActivity, forKey: "recentActivityKey")
        aCoder.encodeObject(_rivals, forKey: "rivalsKey")
        aCoder.encodeObject(_messages, forKey: "messagesKey")
    }
    
    init (userKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._userKey = userKey
        if let id = dictionary["id"] as? String {
            self._userId = id
        }
        if let profileImageURL = dictionary["profileImageUrl"] as? String {
            self._profileImageURL = profileImageURL
        } 
        if let firstName = dictionary["firstName"] as? String {
            self._firstName = firstName
        }
        if let lastName = dictionary["lastName"] as? String {
            self._lastName = lastName
        }
        if let gender = dictionary["gender"] as? String {
            self._gender = gender
        }
        if let provider = dictionary["provider"] as? String {
            self._provider = provider
        }
        if let posts = dictionary["posts"] as? [String] {
            self._posts = posts
        }
        if let sports = dictionary["Sports"] as? [String] {
            self._sports = sports
        }
        if let rating = dictionary["rating"] as? String {
            self._rating = rating
        }
        if let recentActivity = dictionary["recentActivity"] as? [String] {
            self._recentActivity = recentActivity
        }
        if let rivals = dictionary["rivals"] as? [String] {
            self._rivals = rivals
        }
        if let messages = dictionary["messages"] as? [String] {
            self._messages = messages
        }
        if let notifications = dictionary["notifications"] as? [NotificationModel] {
            self._notifications = notifications
        }
    }
    
    func toString() -> String {
        return "id " + self._userId
    }
}