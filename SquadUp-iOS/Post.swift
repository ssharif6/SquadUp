//
//  Post.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/23/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _postDescription: String!
    private var _imageUrl: String?
    private var _numLikes: Int!
    private var _id: String!
    private var _postKey: String!
    private var _activity: String!
    private var _name: String!
    private var _postRef: Firebase!

    var postDescription: String {
        return _postDescription
    }
    
    var postKey: String {
        return _postKey
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
    
    var id: String {
        return _id
    }
    
    var activity: String {
        return _activity
    }
    
    init(description: String, imageUrl: String?, id: String) {
        self._postDescription = postDescription
        self._imageUrl = imageUrl
        self._id = id
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        if let likes = dictionary["numLikes"] as? Int {
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
        if let id = dictionary["id"] as? String {
            self._id = id
        }
        // Reference to Post
        self._postRef = DataService.ds.REF_POSTS.childByAppendingPath(self._postKey)
        
    }
    
    func adjustLikes(addLike: Bool) {
        // If true, add like, false remove like
        if addLike {
            _numLikes = _numLikes + 1
        } else {
            _numLikes = _numLikes - 1
        }
        _postRef.childByAppendingPath("numLikes").setValue(_numLikes)
    }
    
}