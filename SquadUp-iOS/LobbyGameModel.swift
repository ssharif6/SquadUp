//
//  LobbyGameModel.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/8/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import Foundation
import Firebase

class LobbyGameModel {
    private var _lobbyId: String!
    private var _lobbyName: String!
    private var _maxCapacity: String!
    private var _currentCapacity: String!
    private var _currentPlayers: [String]!
    private var _currentLobbyRef: Firebase!
    private var _lobbyKey: String!
    
    var lobbyName: String {
        return _lobbyName
    }
    
    var maxCapacity: String {
        return _maxCapacity
    }
    
    var currentCapacity: String {
        return _currentCapacity
    }
    
    var currentPlayers: [String] {
        return _currentPlayers
    }
    
    
    init(lobbyKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._lobbyKey = lobbyKey
        if let lobbyName = dictionary["lobbyName"] as? String {
            self._lobbyName = lobbyName
        }
        if let maxCapacity = dictionary["maxCapacity"] as? String {
            self._maxCapacity = maxCapacity
        }
        if let currentCapacity = dictionary["currentCapacity"] as? String {
            self._currentCapacity = currentCapacity
        }
        if let currentPlayers = dictionary["currentPlayers"] as? [String] {
            self._currentPlayers = currentPlayers
        }
    }
}