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
    var lobbyObjectToPass: LobbyGameModel!
    var sportPassed: String!
    
    override func viewDidAppear(animated: Bool) {
        self.sportsTableView.reloadData()
        sportsTableView.dataSource = self
        sportsTableView.delegate = self
        sportLabel.text = sportPassed + " Lobby"
        sportLabel.textAlignment = .Center;
        DataService.ds.REF_LOBBYGAMES.observeEventType(.Value, withBlock: { snapshot in
            self.lobbyGames = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let gameLobbyDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let lobbyGame = LobbyGameModel(lobbyKey: key, dictionary: gameLobbyDict)
                        print(lobbyGame.sport)
                        if lobbyGame.sport == self.sportPassed {
                            print("HALLELUJA")
                            self.lobbyGames.append(lobbyGame)
                        }
                    }
                }
            }
            self.sportsTableView.reloadData()
        })

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsTableView.dataSource = self
        sportsTableView.delegate = self
        sportLabel.text = sportPassed + " Lobby"
        sportLabel.textAlignment = .Center;
        DataService.ds.REF_LOBBYGAMES.observeEventType(.Value, withBlock: { snapshot in
            self.lobbyGames = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let gameLobbyDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let lobbyGame = LobbyGameModel(lobbyKey: key, dictionary: gameLobbyDict)
                        print(lobbyGame.sport)
                        print(self.sportPassed)
                        if lobbyGame.sport == self.sportPassed {
                            print("HALLELUJA")
                            self.lobbyGames.append(lobbyGame)
                        }
                    }
                }
            }
            self.sportsTableView.reloadData()
        })
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! JoinLobbyCell
        let lobbyObjectToPass = self.lobbyGames[indexPath.row]
        self.lobbyObjectToPass = lobbyObjectToPass
        performSegueWithIdentifier("lobbyToGame", sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lobbyGames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let lobbyGame = lobbyGames[indexPath.row]
        if let cell: JoinLobbyCell = tableView.dequeueReusableCellWithIdentifier("JoinLobbyCell") as? JoinLobbyCell {
            cell.configureCell(lobbyGame)
            if lobbyGame.registered == "yes" {
                
                cell.backgroundColor = UIColor(red: 0, green: 123, blue: 181, alpha: 1.0)
                cell.textLabel?.textColor = UIColor.whiteColor()
            }
            return cell
        } else {
            return JoinLobbyCell()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "lobbyToGame" {
            let vc = segue.destinationViewController as! GameLobbyViewController
            vc.lobbyModelObject = self.lobbyObjectToPass
        }
    }
    
}
