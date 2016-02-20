//
//  PublicProfileViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/20/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class PublicProfileViewController: UIViewController {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var recentHistoryButton: UIButton!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var requestRivalButton: UIButton!
    @IBOutlet weak var oneStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    var userPassed: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}
