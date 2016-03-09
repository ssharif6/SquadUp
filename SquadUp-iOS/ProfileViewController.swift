//
//  ProfileViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/24/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var recentHistoryButton: UIButton!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var findRivalButton: UIButton!
    @IBOutlet weak var oneStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    var lobbyObjectPassed: LobbyGameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.blackColor().CGColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func cameraButtonClicked(sender: AnyObject) {
    }
    @IBAction func moreButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func findRivalButtonClicked(sender: AnyObject) {
    }
    @IBAction func recentActivityClicked(sender: AnyObject) {
    }
    
    
}