//
//  UserModel.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/3/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserModel {
    private var _userId: String!
    private var _firstName: String!
    private var _lastName: String!
    private var _gender: String!
    private var _posts: [String]!
    private var _sports: [String]!
    
    var firstName: String {
        return _firstName
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
    
    init(firstName: String, lastName: String, gender: String, userId: String, posts: [String], sports: [String]) {
        _firstName = firstName
        _lastName = lastName
        _gender = gender
        _userId = userId
        _posts = posts
        _sports = sports
    }
}