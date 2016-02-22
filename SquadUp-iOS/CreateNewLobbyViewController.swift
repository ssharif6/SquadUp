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
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var passedLocationString: String?
    var passedLobbyName: String?
    var passedDescription: String?
    var numPlayersPassed: String?
    var lobbyObjectToPass: LobbyGameModel!
    var sportPassed: String!
    var sportLabel: String?
    var selectedDate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        if passedLocationString != nil {
            locationAddressTextField.text = passedLocationString
        }
        if passedLobbyName != nil {
            lobbyNameTextField.text = passedLobbyName
        }
        if passedDescription != nil {
            descriptionTextField.text = passedDescription
        }
        if numPlayersPassed != nil {
            numPlayersTextField.text = numPlayersPassed
        }
        if sportPassed != nil {
            sportLabel = sportPassed
        }
        viewDidLoad()
    }
    
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func displayError() -> Bool{
        var emptyText = ""
        if lobbyNameTextField.text == "" {
            emptyText += "Lobby Name"
        } else if descriptionTextField.text == "" {
            emptyText += "Description"
        } else if numPlayersTextField.text == "" {
            emptyText += "Number Of Players Field"
        } else if locationAddressTextField.text == "" {
            emptyText += "Location Field"
        }
        if emptyText != "" {
            let alert = UIAlertController(title: "All Fields Must be Filled In", message: "Not all Fields are Filled In", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return true
        }
        
        return false
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        self.selectedDate = strDate
        print(strDate)
    }
    
    @IBAction func createLobbyPressed (sender: AnyObject) {
        if(displayError() == false) {
            let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
            let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
            var userArray = [String]()
            userArray.append(userUnarchived.userKey)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let strDate = dateFormatter.stringFromDate(datePicker.date)
            self.selectedDate = strDate
            
            let lobby: Dictionary<String, AnyObject> = [
                "distance": "0.9",
                "lobbyName": lobbyNameTextField.text!,
                "maxCapacity": Int(numPlayersTextField.text!)!,
                "sportsID": sportLabel!,
                "description": descriptionTextField.text!,
                "currentCapacity": 1,
                "currentPlayers": userArray,
                "location": locationAddressTextField.text!,
                "date": self.selectedDate,
                "registered": "no",
                "address": self.locationAddressTextField.text!
            ]
            let lobbyPost = DataService.ds.REF_LOBBYGAMES.childByAutoId()
            lobbyPost.setValue(lobby)
            self.lobbyObjectToPass = LobbyGameModel(lobbyKey: lobbyPost.key, dictionary: lobby)
            performSegueWithIdentifier("CreateLobbyToLobby", sender: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LocationButtonToMap" {
            let vc = segue.destinationViewController as! MapViewController
            if lobbyNameTextField != nil {
                vc.lobbyNamePassed = lobbyNameTextField.text!
            }
            if descriptionTextField != nil {
                vc.descriptionPassed = descriptionTextField.text!
            }
            if numPlayersTextField != nil {
                vc.numPlayersPassed = numPlayersTextField.text!
            }
            vc.sportPassed = self.sportPassed
        } else if segue.identifier == "CreateLobbyToLobby" {
            let vc = segue.destinationViewController as! GameLobbyViewController
            vc.lobbyModelObject = self.lobbyObjectToPass
        }
    }
    
    
}
