//
//  PublicRecentActivityViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/6/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class PublicRecentActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userPassed: UserModel!
    var gameIds: [String]!
    var games = [LobbyGameModel]()
    var gameToPass: LobbyGameModel!
    
    @IBOutlet weak var recentActivityTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
    }
    
    func parseData() {
        gameIds = userPassed.recentActivity
        for game in gameIds {
            DataService.ds.REF_LOBBYGAMES.observeEventType(.Value, withBlock: { snapshot in
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                    for snap in snapshots {
                        if let lobbyDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            if(key == game) {
                                let lobbyGame = LobbyGameModel(lobbyKey: key, dictionary: lobbyDict)
                                self.games.append(lobbyGame)
                            }
                            
                        }
                    }
                }
                self.recentActivityTable.reloadData()
            })
        }

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let game = games[indexPath.row]
        self.gameToPass = game
        performSegueWithIdentifier("RecentHistoryToGameLobby", sender: nil)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PublicRecentActivityCell") as! RecentActivityTableViewCell
        let game = games[indexPath.row]
        cell.configureCell(game)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RecentHistoryToGameLobby" {
            let vc = segue.destinationViewController as! GameLobbyViewController
            vc.lobbyModelObject = self.gameToPass
            vc.fromRecentActivity = true
        }
    }
}
