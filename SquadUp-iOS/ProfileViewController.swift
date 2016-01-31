//
//  ProfileViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/24/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var coverImage: UIImageView!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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