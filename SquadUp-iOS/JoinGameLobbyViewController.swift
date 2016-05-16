//
//  JoinGameLobbyViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/7/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase
import LiquidFloatingActionButton

class JoinGameLobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate {
    
    @IBOutlet weak var sportLabelImage: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var sportsTableView: UITableView!
    @IBOutlet weak var subscribedImage: UIImageView!
    @IBOutlet weak var sportBackgroundImage: UIImageView!
    
    var lobbyGames = [LobbyGameModel]()
    var lobbyObjectToPass: LobbyGameModel!
    var sportPassed: String!
    
    // LiquidFloatingButton
    var ButtonCells = [LiquidFloatingCell]()
    var floatingActionButton: LiquidFloatingActionButton!
    

    override func viewDidAppear(animated: Bool) {
        self.sportsTableView.reloadData()
        sportsTableView.dataSource = self
        sportsTableView.delegate = self

        createFloatingButtons()

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
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        self.floatingActionButton.hidden = true
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.floatingActionButton.hidden = false

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
        mapViewController.gameLobbyArray = self.lobbyGames
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
    
    // For floating button
    private func createFloatingButtons() {
        ButtonCells.removeAll()
        ButtonCells.append(createButtonCell("mapIconLarge"))
        ButtonCells.append(createButtonCell("Steph"))
        ButtonCells.append(createButtonCell("Steph"))

//        ButtonCells.append(createButtonCell("Use Maps Icon"))
        
        let floatingFrame = CGRectMake(self.view.frame.width - 26 - 56, self.view.frame.height - 76 - 56, 56, 56)
        let floatingButton = createButton(floatingFrame, style: .Up)
        self.view.addSubview(floatingButton)
        self.floatingActionButton = floatingButton
    }
    
    private func createButton(frame: CGRect, style: LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton {
        let floatingActionButton = LiquidFloatingActionButton(frame: frame)
        floatingActionButton.color = UIColor.rgb(0, green: 172, blue: 237)
        floatingActionButton.animateStyle = style
        floatingActionButton.dataSource = self
        floatingActionButton.delegate = self
        return floatingActionButton
    }
    
    private func createButtonCell(iconName: String) -> LiquidFloatingCell {
        return LiquidFloatingCell(icon: UIImage(named: iconName)!)
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return ButtonCells[index]
    }
    
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return ButtonCells.count
    }
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        if(index == 0) {
            openMapSearch()
        } else if index == 1 {
            let vc = CreateNewLobbyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        liquidFloatingActionButton.close()
        // First button Map
        // Second button Find by Game Name
        // Create Game
        // Find by Person
        // Find by Level
    }
    
}
