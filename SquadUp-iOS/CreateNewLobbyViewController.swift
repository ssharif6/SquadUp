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
    }
    
    override func viewDidAppear(animated: Bool) {
        if passedLocationString != nil {
            locationAddressTextField.text = passedLocationString
        }
    }
    
    @IBAction func createLobbyPressed (sender: AnyObject) {
        
    }
    
    @IBAction func findLocationButtonPressed(sender: AnyObject) {
        
    }
    
    
}
