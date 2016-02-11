//
//  GameLobbyViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/8/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class GameLobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lobbyNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var team1View: UIView!
    @IBOutlet weak var team1ContainerView: UIView!
    @IBOutlet weak var team1TableView: UITableView!
    @IBOutlet weak var teamSegmentedControl: UISegmentedControl!
    
    var teamOneArray:[String]!
    var teamTwoArray: [String]!
    var playersInLobby: [UserModel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        team1TableView.dataSource = self
        team1TableView.delegate = self

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch(teamSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            returnValue = teamOneArray.count
            break
        case 1:
            returnValue = teamTwoArray.count
            break
        default:
            break
        }
        return returnValue
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath)
        switch(teamSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = teamOneArray[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = teamTwoArray[indexPath.row]
            break
        default:
            break
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func getTeamInfo() {
        // Grab data from Firebase and put into teams
//        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
//            self.posts = []
//            // Parse Firebase Data
//            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
//                for snap in snapshots {
//                    print("SNAP \(snap)")
//                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
//                        let key = snap.key
//                        let post = Post(postKey: key, dictionary: postDict)
//                        self.posts.append(post)
//                    }
//                }
//            }
//            self.tableView.reloadData()
//        })
        // TODO: Refactor and pass the given lobby through segue so don't have to query database again
        
        DataService.ds.REF_LOBBYGAMES.observeEventType(.Value) { (snapshot: FDataSnapshot!) -> Void in
            self.playersInLobby = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let lobbyDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let lobby = LobbyGameModel(lobbyKey: key, dictionary: lobbyDict)
                        let currentUsers = lobby.currentPlayers
                        for(var i = 0; i < currentUsers.count; i++) {
                            self.playersInLobby[i] = currentUsers[i]
                        }
                    }
                }
            }
        }
    }

}
