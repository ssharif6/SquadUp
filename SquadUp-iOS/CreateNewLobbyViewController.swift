//
//  CreateNewLobbyViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/17/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class CreateNewLobbyViewController: UIViewController {
    
    @IBOutlet weak var lobbyNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var numPlayersTextField: UITextField!
    @IBOutlet weak var locationAddressTextField: UITextField!
    
    var passedLocationString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        if passedLocationString != nil {
            locationAddressTextField.text = passedLocationString
        }
        viewDidLoad()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func createLobbyPressed (sender: AnyObject) {
        let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
        let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
        var userArray = [String]()
        userArray.append(userUnarchived.userKey)
        let lobby: Dictionary<String, AnyObject> = [
            "distance": "0.9",
            "lobbyName": lobbyNameTextField.text!,
            "maxCapacity": numPlayersTextField.text!,
            "sportsID": "basketball",
            "currentCapacity": "1",
            "currentPlayers": userArray]
        let lobbyPost = DataService.ds.REF_LOBBYGAMES.childByAutoId()
        lobbyPost.setValue(lobby)
    }
    
    @IBAction func findLocationButtonPressed(sender: AnyObject) {
        
    }
    
    
}
