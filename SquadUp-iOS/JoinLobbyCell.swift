//
//  JoinLobbyCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/7/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class JoinLobbyCell: UITableViewCell {
    @IBOutlet weak var lobbyName: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var numPeople: UILabel!
    
    var gameLobby: LobbyGameModel!
    var request = Request?()
    var currentTotalPlayers: String!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(gameLobby: LobbyGameModel) {
        self.gameLobby = gameLobby
        self.lobbyName.text = gameLobby.lobbyName + " " + gameLobby.sport
        currentTotalPlayers = gameLobby.currentCapacity + " /" + " " + gameLobby.maxCapacity
        self.numPeople.text = currentTotalPlayers
//        self.distanceLabel.text = gameLobby.distance
    }
    
    // Add functgions for when somebody joins the lobby to increment the currentcapacity
}
