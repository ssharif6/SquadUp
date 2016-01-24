//
//  Post.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/23/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import Foundation

class Post {
    private var _postDescription: String!
    private var _imageUrl: String?
    private var _numLikes: Int!
    private var _username: String!
    private var _postKey: String!
    private var _activity: String!
    private var _name: String!

    var postDescription: String {
        return _postDescription
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    var name: String {
        return _name
    }
    
    var numLikes: Int {
        return _numLikes
    }
    
    var username: String {
        return _username
    }
    
    var activity: String {
        return _activity
    }
    
    init(description: String, imageUrl: String?, username: String) {
        self._postDescription = postDescription
        self._imageUrl = imageUrl
        self._username = username
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        if let likes = dictionary["TotalLikes"] as? Int {
            self._numLikes = likes
        }
        if let imageUrl = dictionary["profileImageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        if let desc = dictionary["PostDescription"] as? String {
            self._postDescription = desc
        }
        if let activity = dictionary["activity"] as? String {
            self._activity = activity
        }
        if let name = dictionary["name"] as? String {
            self._name = name
        }
    }
    
}