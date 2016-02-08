//
//  JoinGameLobbyViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/7/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class JoinGameLobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var sportsTableView: UITableView!
    
    var lobbyGames = [LobbyGameModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        sportsTableView.dataSource = self
        sportsTableView.delegate = self
        
        DataService.ds.REF_LOBBYGAMES.observeEventType(.Value, withBlock: { snapshot in
            self.lobbyGames = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let gameLobbyDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let lobbyGame = LobbyGameModel(lobbyKey: key, dictionary: gameLobbyDict)
                        self.lobbyGames.append(lobbyGame)
                    }
                }
            }
            self.sportsTableView.reloadData()
        })

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lobbyGames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let lobbyGame = lobbyGames[indexPath.row]
        if let cell: JoinLobbyCell = tableView.dequeueReusableCellWithIdentifier("JoinLobbyCell") as? JoinLobbyCell {
            cell.configureCell(lobbyGame)
            return cell
        } else {
            return JoinLobbyCell()
        }
    }

}
