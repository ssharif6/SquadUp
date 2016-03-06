//
//  RecentActivityViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/20/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class RecentActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var recentActivityTableView: UITableView!
    
    var games = [LobbyGameModel]()
    var gameIds: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
    }
    
    func parseData() {
        let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
        let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
        gameIds = userUnarchived.recentActivity
        
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
            self.recentActivityTableView.reloadData()
            })
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecentActivityCell") as! RecentActivityTableViewCell
        let game = games[indexPath.row]
        cell.configureCell(game)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

}
