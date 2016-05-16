//
//  ProfileViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/24/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import IOStickyHeader
import Firebase

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var lobbyObjectPassed: LobbyGameModel!
    
    var gameIds: [String]!
    var gameToPass: LobbyGameModel!
    
    let headerNib = UINib(nibName: "ProfileHeader", bundle: NSBundle.mainBundle())
    var data = [[LobbyGameModel]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.parseGameData()
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        if let layout: IOStickyHeaderFlowLayout = self.collectionView.collectionViewLayout as? IOStickyHeaderFlowLayout {
            layout.parallaxHeaderReferenceSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 463)
            layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 0)
            layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, layout.itemSize.height)
            layout.parallaxHeaderAlwaysOnTop = true
            layout.disableStickyHeaders = true
            self.collectionView.collectionViewLayout = layout
        }
        
        self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.collectionView.registerNib(self.headerNib, forSupplementaryViewOfKind: IOStickyHeaderParallaxHeader, withReuseIdentifier: "header")
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
        let cell: RecentActivityCell = collectionView.dequeueReusableCellWithReuseIdentifier("recent activity cell", forIndexPath: indexPath) as! RecentActivityCell
        cell.configureCell(data[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
    }
    
    // MARK loading data n' shit
    func parseGameData() {
        let user = NSUserDefaults.standardUserDefaults().dataForKey("userModelKey")!
        let userUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(user) as! UserModel
        gameIds = userUnarchived.recentActivity
        
        for game in gameIds {
            DataService.ds.REF_LOBBYGAMES.observeEventType(.Value, withBlock: { snapshot in
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                    for snap in snapshots {
                        if let lobbyDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            if(key == game) {
                                let lobbyGame = LobbyGameModel(lobbyKey: key, dictionary: lobbyDict)
                                self.data[0].append(lobbyGame)
                            }
                            
                        }
                    }
                }
                self.collectionView.reloadData()
            })
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case IOStickyHeaderParallaxHeader:
            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! ProfileHeader
            cell.profileImage.layer.borderWidth = 0.5
            cell.profileImage.layer.masksToBounds = false
            cell.profileImage.layer.borderColor = UIColor.blackColor().CGColor
            cell.profileImage.layer.cornerRadius = cell.profileImage.frame.height/2
            cell.profileImage.clipsToBounds = true
            return cell
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
}
