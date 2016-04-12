//
//  ProfileViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/24/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    
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
    @IBOutlet weak var collectionView: UICollectionView!
    
    var lobbyObjectPassed: LobbyGameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.blackColor().CGColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerClass(SuggestedRivalCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceHorizontal = true
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

    // MARK UICollectionView Delegate Methods
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SuggestedRivalCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
    }
    
}
