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
    private var _distance: String!
    private var _sportsId: String!
    private var _currentPlayersList = [UserModel]()
    
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
    
    var distance: String {
        return _distance
    }
    
    var sport: String {
        return _sportsId
    }
    
    var currentPlayersList: [UserModel] {
        return _currentPlayersList
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
        if let distance = dictionary["distance"] as? String {
            self._distance = distance
        }
        if let sportsId = dictionary["sportsID"] as? String {
            self._sportsId = sportsId
        }
        if let lobbyId = dictionary["id"] as? String {
            self._lobbyId = lobbyId
        }
    }
    
    func getCurrentPlayers() -> [UserModel] {
        var currentIdList = _currentPlayers
        var currentPlayersList = [UserModel]()
        for player in _currentPlayers {
            DataService.ds.REF_USERS.queryOrderedByChild("id").queryStartingAtValue(player).queryLimitedToFirst(1).observeEventType(.Value, withBlock: { (snapshot) -> Void in
                self._currentPlayersList = []
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                    var snap = snapshots[0]
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let user = UserModel(userKey: key, dictionary: userDict)
                        print(user.firstName)
                        print("SHIT")
                        currentPlayersList.append(user)
                        print("FUCK")
                        print(currentPlayersList.count)
                    }
                }
            })
        }
        return currentPlayersList
    }
}