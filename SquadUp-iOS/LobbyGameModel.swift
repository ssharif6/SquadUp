//
//  LobbyGameModel.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/8/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class LobbyGameModel {
    private var _lobbyId: String!
    private var _lobbyName: String!
    private var _maxCapacity: Int!
    private var _currentCapacity: Int!
    private var _currentPlayers: [String]!
    private var _currentLobbyRef: Firebase!
    private var _lobbyKey: String!
    private var _distance: String!
    private var _sportsId: String!
    private var _address: String!
    private var _description: String!
    private var _date: String!
    private var _registered: String!
    private var _currentPlayersList = [UserModel]()
    private var _gameLatitude: Double!
    private var _gameLongitude: Double!
    
    var gameLocationCoordinate: CLLocationCoordinate2D {
        let coordinate = CLLocationCoordinate2DMake(_gameLatitude, _gameLongitude)
        return coordinate
    }
    
    var lobbyName: String {
        return _lobbyName
    }
    
    var date: String {
        return _date
    }
    
    var registered: String {
        return _registered
    }
    
    var description: String {
        return _description
    }
    
    var address: String {
        return _address
    }
    
    var maxCapacity: Int {
        return _maxCapacity
    }
    
    var currentCapacity: Int {
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
    
    var lobbyKey: String {
        return _lobbyKey
    }
    
    init(lobbyKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._lobbyKey = lobbyKey
        if let lobbyName = dictionary["lobbyName"] as? String {
            self._lobbyName = lobbyName
        }
        if let maxCapacity = dictionary["maxCapacity"] as? Int {
            self._maxCapacity = maxCapacity
        }
        if let currentCapacity = dictionary["currentCapacity"] as? Int {
            self._currentCapacity = currentCapacity
        }
        if let currentPlayers = dictionary["currentPlayers"] as? [String] {
            self._currentPlayers = currentPlayers
            print(currentPlayers)
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
        if let address = dictionary["address"] as? String {
            self._address = address
        }
        if let date = dictionary["date"] as? String {
            self._date = date
        }
        if let description = dictionary["description"] as? String {
            self._description = description
        }
        if let registered = dictionary["registered"] as? String {
            self._registered = registered
        }
        if let latitude = dictionary["latitude"] as? Double {
            self._gameLatitude = latitude
        }
        if let longitude = dictionary["longitude"] as? Double {
            self._gameLongitude = longitude
        }
        
    }
    
    func checkIfMaxCapacity() -> Bool{
        if _currentCapacity == _maxCapacity {
            return false
        } else {
            return true
        }
    }
    
    func adjustCurrentCapacity(addPlayer: Bool) -> Bool{
        if _currentCapacity < _maxCapacity {
            if addPlayer {
                let numPlayers = self._currentCapacity + 1
                self._currentCapacity = numPlayers
                DataService.ds.REF_LOBBYGAMES.childByAppendingPath(self._lobbyKey).childByAppendingPath("currentCapacity").setValue(numPlayers)
            } else {
                let numPlayers = self._currentCapacity - 1
                self._currentCapacity = numPlayers
                DataService.ds.REF_LOBBYGAMES.childByAppendingPath(self._lobbyKey).childByAppendingPath("currentCapacity").setValue(numPlayers)
            }

        } else {
            return false // throw error
        }
        return true
    }
    
}