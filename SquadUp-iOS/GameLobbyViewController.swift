//
//  GameLobbyViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/8/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase
import Cosmos
import MapKit

class GameLobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lobbyNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var team1ContainerView: UIView!
    @IBOutlet weak var team1TableView: UITableView!
    @IBOutlet weak var teamSegmentedControl: UISegmentedControl!
    @IBOutlet weak var joinButton: UIButton!
    
    var lobbyModelObject: LobbyGameModel!
    var teamOneArray = [UserModel]()
    var teamTwoArray = [UserModel]()
    var playersInLobby = [UserModel]()
    var playerIdList = [String]()
    var team1: Bool!
    var currentUser: UserModel!
    var fromRecentActivity: Bool! = false
    var coords: CLLocationCoordinate2D?
    var placemarkPassed: MKPlacemark?
    
    
    override func viewDidAppear(animated: Bool) {
        team1TableView.dataSource = self
        team1TableView.delegate = self
        if fromRecentActivity == true {
            joinButton.hidden = true
        }
        getUsers()
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if fromRecentActivity == true {
            joinButton.hidden = true
        }
        displayLobbyInfo()
        team1TableView.dataSource = self
        team1TableView.delegate = self
        getUsers()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        fromRecentActivity = false
    }

    
    func displayLobbyInfo() {
        lobbyNameLabel.text = lobbyModelObject.lobbyName
        lobbyNameLabel.textAlignment = .Center
        descriptionLabel.text = lobbyModelObject.description
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let convertedDate = dateFormatter.dateFromString(lobbyModelObject.date)
        timeLabel.text = dateFormatter.stringFromDate(convertedDate!)
        addressButton.setTitle(lobbyModelObject.address, forState: .Normal)
    }
    
    func divideTeams() {
        teamOneArray = []
        teamTwoArray = []
        var shit: Bool = true
        for player in self.playersInLobby {
            if (shit) {
                teamOneArray.append(player)
            } else {
                teamTwoArray.append(player)
            }
            shit = !shit
        }
        print("Team 1")
        print(teamOneArray)
        print("Team 2")
        print(teamTwoArray)
    }
    
    func getUsers() {
        var asdf = [UserModel]()
        print(self.lobbyModelObject.currentPlayers)
        DataService.ds.REF_USERS.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            // Parse Firebase Data
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        if (self.lobbyModelObject.currentPlayers.contains(snap.key)) {
                            print("found")
                            let user = UserModel(userKey: key, dictionary: userDict)
                            asdf.append(user)
                        } else {
                            print("not found")
                        }
                    }
                }
            }
            self.playersInLobby = asdf
            self.divideTeams()
            self.team1TableView.reloadData()
            print(self.playersInLobby)
        })
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch(teamSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            returnValue = teamOneArray.count
            team1 = true
            break
        case 1:
            returnValue = teamTwoArray.count
            team1 = false
            break
        default:
            break
        }
        return returnValue
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) as! GameLobbyTableViewCell
        switch(teamSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            let user = teamOneArray[indexPath.row]
            cell.configureCell(user, fromRecentActivity: self.fromRecentActivity)
            break
        case 1:
            let user = teamTwoArray[indexPath.row]
            cell.configureCell(user, fromRecentActivity: self.fromRecentActivity)
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func controlChanged(sender: AnyObject) {
        team1TableView.reloadData()
    }
    @IBAction func joinTeam(sender: AnyObject) {
        joinButton.enabled = false
        let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
        let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
        if lobbyModelObject.checkIfMaxCapacity() == true {
            lobbyModelObject.adjustCurrentCapacity(true)
            let post = DataService.ds.REF_LOBBYGAMES.childByAppendingPath(lobbyModelObject.lobbyKey).childByAppendingPath("currentPlayers").childByAppendingPath(String(self.lobbyModelObject.currentPlayers.count))
            post.setValue(userUnarchived.userKey)
            playersInLobby.append(userUnarchived)
            print(userUnarchived.firstName)
            self.divideTeams()
        } else {
            let alert = UIAlertController(title: "Game is Full", message: "The Maximum Number of Players has been Reached.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        self.team1TableView.reloadData()
        
    }
    @IBAction func addressClicked(sender: AnyObject) {
        
    }
}


