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
    
    var firstName: String {
        return _firstName
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
    
    init(key: String, firstName: String, lastName: String, gender: String, userId: String, posts: [String], sports: [String]) {
        _firstName = firstName
        _lastName = lastName
        _gender = gender
        _userId = userId
        _posts = posts
        _sports = sports
        _userKey = key
    }
    
    required init(coder decoder: NSCoder) {
        self._firstName = decoder.decodeObjectForKey("firstName") as! String
        self._lastName = decoder.decodeObjectForKey("lastName") as! String
        self._gender = decoder.decodeObjectForKey("gender") as! String
        _userId = decoder.decodeObjectForKey("userId") as? String
        _posts = decoder.decodeObjectForKey("posts") as? [String]
        _sports = decoder.decodeObjectForKey("sports") as? [String]
        _userKey = decoder.decodeObjectForKey("userKey") as? String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(_firstName, forKey: "firstName")
        aCoder.encodeObject(_lastName, forKey: "lastName")
        aCoder.encodeObject(_gender, forKey: "gender")
        aCoder.encodeObject(_posts, forKey: "posts")
        aCoder.encodeObject(_sports, forKey: "sports")
        aCoder.encodeObject(_userKey, forKey: "userKey")
    }
    
    init (userKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._userKey = userKey
        if let id = dictionary["id"] as? String {
            self._userId = id
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
    }
    
    func toString() -> String {
        return "id " + self._userId
    }
}