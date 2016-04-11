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
    
    @IBOutlet weak var sportLabelImage: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var sportsTableView: UITableView!
    @IBOutlet weak var subscribedImage: UIImageView!
    @IBOutlet weak var sportBackgroundImage: UIImageView!
    
    var lobbyGames = [LobbyGameModel]()
    var lobbyObjectToPass: LobbyGameModel!
    var sportPassed: String!
    
    override func viewDidAppear(animated: Bool) {
        self.sportsTableView.reloadData()
        sportsTableView.dataSource = self
        sportsTableView.delegate = self

//        sportLabel.text = sportPassed + " Lobby"
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
        let imageText = sportPassed + "Lobby"
        sportLabelImage.image = UIImage(named: imageText)
        let sportImageBG = sportPassed + "Background"
        // Eventually Add Image Icon
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(openMapSearch))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(openMapSearch))
        
        self.sportBackgroundImage.image = UIImage(named: sportImageBG)
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
                            self.lobbyGames.append(lobbyGame)
                        }
                    }
                }
            }
            self.sportsTableView.reloadData()
        })
        
    }
    
    func openMapSearch() {
        // open MapView that has pins for locations
        let mapViewController = FindGameMapView()
        self.navigationController?.pushViewController(mapViewController, animated: true)
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
