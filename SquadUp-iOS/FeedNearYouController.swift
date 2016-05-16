//
//  FeedNearYouController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 4/14/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class FeedNearYouController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate, CLLocationManagerDelegate {
    private var CellId = "cellId"
    private var lobbyGames = [LobbyGameModel]()
    private var lobbyToPass: LobbyGameModel!
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D!
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), forControlEvents: UIControlEvents.ValueChanged)
        collectionView?.addSubview(refreshControl)
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        navigationItem.title = "Events Near You"
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.rgb(220, green: 220, blue: 220)
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: CellId)
        navigationController?.navigationBar.tintColor = UIColor.rgb(0, green: 171, blue: 236)
        parseData()
//        lobbyGames.sortInPlace { (element1, element2) -> Bool in
//            let a: Double? = Double(element1.distance)
//            let b: Double? = Double(element2.distance)
//            return a < b
//        }
    }
    
    func refresh() {
        parseData()
        self.refreshControl.endRefreshing()
    }
    
    // Mark: Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations.last!
        self.currentLocation = userLocation.coordinate
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lobbyGames.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellId, forIndexPath: indexPath) as! FeedCell
        self.lobbyToPass = lobbyGames[indexPath.row]
        cell.joinButton.addTarget(self, action: #selector(FeedNearYouController.joinButtonClicked(_:)), forControlEvents: .TouchDown)
        cell.locationButton.addTarget(self, action: #selector(FeedNearYouController.locationButtonCLicked(_:)), forControlEvents: .TouchDown)
        cell.favoriteButton.addTarget(self, action: #selector(FeedNearYouController.favoriteButtonClicked(_:)), forControlEvents: .TouchDown)
        cell.configureCell(lobbyGames[indexPath.row])
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 400)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.lobbyToPass = lobbyGames[indexPath.row]
        performSegueWithIdentifier("CollectionViewToGameLobby", sender: self)
    }
    
    // Inverting
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CollectionViewToGameLobby" {
            let vc = segue.destinationViewController as! GameLobbyViewController
            vc.lobbyModelObject = self.lobbyToPass
        }
    }
    
    func locationButtonCLicked(sender: UIButton) {
        let mapViewController = FindGameMapView()
        var array = [LobbyGameModel]()
        array.append(lobbyToPass)
        mapViewController.gameLobbyArray = array
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    func joinButtonClicked(sender: UIButton) {
        performSegueWithIdentifier("CollectionViewToGameLobby", sender: self)
    }
    
    func favoriteButtonClicked(sender: UIButton) {
        // Open a Modal to type in a comment
    }
    
    // MARK: Download Data from Firebase
    func parseData() {
        DataService.ds.REF_LOBBYGAMES.queryOrderedByChild("distance").observeEventType(.Value, withBlock: { snapshot in
            self.lobbyGames = []
            // Parse Firebase Data
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let lobbyGameDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let lobbyGame = LobbyGameModel(lobbyKey: key, dictionary: lobbyGameDict)
//                        lobbyGame.calculateDistanceAway(self.currentLocation)
                        // Post this to firebase
                        self.lobbyGames.append(lobbyGame)
                    }
                }
            }
            self.collectionView?.reloadData()
        })
    }
}

class FeedCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override var highlighted: Bool {
        didSet {
            backgroundColor = highlighted ? UIColor.rgb(0, green: 172, blue: 237) : UIColor.whiteColor()
//            labelSport.textColor = highlighted ? UIColor.whiteColor() : UIColor.blackColor()
            distanceLabel.textColor = highlighted ? UIColor.whiteColor() : UIColor.lightGrayColor()
//            sportInformationTextView.textColor = highlighted ? UIColor.whiteColor() : UIColor.blackColor()
            numPeopleGoingLabel.textColor = highlighted ? UIColor.whiteColor() : UIColor.lightGrayColor()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Data of Cell set here
    func configureCell(gameLobby: LobbyGameModel) {
        // set all the variables here
        labelSport.text = gameLobby.sport + " " + gameLobby.lobbyName
        labelSport.textColor = UIColor.whiteColor()
        distanceLabel.text = gameLobby.distance + " Mi"
        sportInformationTextView.text = gameLobby.description
        var locationButtonText = "\(gameLobby.city), \(gameLobby.state)"
        locationButton.setTitle(locationButtonText, forState: .Normal)
        locationButton.setImage(UIImage(named: "mapIconSmall-12"), forState: .Normal)
        sportBackgroundImageView.image = UIImage(named: gameLobby.sport + "Pic")
        joinButton.setTitle("Join", forState: .Normal)
        joinButton.setImage(UIImage(named: "\(gameLobby.sport)JoinIconSmall"), forState: .Normal)
        numPeopleGoingLabel.text = "\(gameLobby.currentCapacity) People Going"
        dateOfGameLabel.text = "\(gameLobby.date)"
    }
    
    
    let labelSport: UILabel = {
       let label = UILabel()
        label.text = "Soccer 11 v 11"
        label.font = UIFont(name: "Arial", size: 34)
        label.textColor = UIColor.whiteColor()
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "0.9 Mi"
        label.font = UIFont(name: "Arial", size: 18)
        label.textColor = UIColor.lightGrayColor()
        return label
    }()
    
    let sportInformationTextView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Basketball Event happening later today at the IMA! Go check it out!"
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    let sportBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Tennis")
        imageView.contentMode = .ScaleToFill
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let dateOfGameLabel: UILabel = {
       let label = UILabel()
        label.text = "Date of Game"
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Arial", size: 16)
        return label
    }()
    
    let numPeopleGoingLabel: UILabel = {
        let label = UILabel()
        label.text = "21 People Going"
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.rgb(155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
        return view
    }()
    
    //MARK: Buttons
    
    let joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join", forState: .Normal)
        button.titleLabel!.font = UIFont(name: "Arial", size: 18)
        button.setTitleColor(UIColor.rgb(143, green: 150, blue: 162), forState: .Normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
        return button
    }()
    
//    let commentButton = FeedCell.buttonForTitle("Comment", imageName: "messageIconSmall")
    let favoriteButton = FeedCell.buttonForTitle("Favorite", imageName: "UnfilledStarSmall")
    let shareButton = FeedCell.buttonForTitle("Share", imageName: "shareIconSmall")
    
    // For 
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
            let button = UIButton()
            button.setTitle(title, forState: .Normal)
            button.titleLabel!.font = UIFont(name: "Arial", size: 18)
            button.setTitleColor(UIColor.rgb(143, green: 150, blue: 162), forState: .Normal)
            button.setImage(UIImage(named: imageName), forState: .Normal)
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
            return button
    }
    
    let locationButton: UIButton = {
        let button = UIButton()
        button.setTitle("San Fransisco, CA", forState: .Normal)
        button.titleLabel!.font = UIFont(name: "Arial", size: 22)
        button.setNeedsLayout()
        button.setTitleColor(UIColor.rgb(255, green: 255, blue: 255), forState: .Normal)
        button.imageView?.image = UIImage(named: "mapIconSmall-12")
        return button
    }()
    
    
    func setupViews() {
        
        let centerX = NSLayoutConstraint(item: locationButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        let centerXSportLabel = NSLayoutConstraint(item: labelSport, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        let centerXDateLabel = NSLayoutConstraint(item: dateOfGameLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        let centerYSportLabel = NSLayoutConstraint(item: labelSport, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)

        backgroundColor = UIColor.whiteColor()
//        addSubview(sportInformationTextView)
        addSubview(sportBackgroundImageView)
        addSubview(numPeopleGoingLabel)
        addSubview(dividerLineView)
        addSubview(joinButton)
        addSubview(favoriteButton)
        addSubview(shareButton)
        addSubview(labelSport)
        addSubview(distanceLabel)
        addSubview(locationButton)
        addSubview(dateOfGameLabel)
        
        addConstraintsWithFormat("H:[v0]-14-|", view: distanceLabel)
        addConstraintsWithFormat("V:|-20-[v0]", view: distanceLabel)
        self.labelSport.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([centerXSportLabel])
        addConstraintsWithFormat("V:|-100-[v0]", view: labelSport)
        addConstraintsWithFormat("H:|[v0]|", view: sportBackgroundImageView)
//        addConstraintsWithFormat("V:|-52-[v0(44)]-4-[v1]-8-[v2(24)]-6-[v3(0.9)][v4(44)]|", view: sportInformationTextView, sportBackgroundImageView, numPeopleGoingLabel, dividerLineView, joinButton)
        addConstraintsWithFormat("V:|[v0]-4-[v1(24)]-6-[v2(0.9)][v3(44)]|", view: sportBackgroundImageView, numPeopleGoingLabel, dividerLineView, joinButton)
        addConstraintsWithFormat("H:|-12-[v0]-12-|", view: numPeopleGoingLabel)
        addConstraintsWithFormat("H:|-12-[v0]-12-|", view: dividerLineView)
        
        // Button Constraints
        addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", view: joinButton, favoriteButton, shareButton)
        addConstraintsWithFormat("V:[v0(44)]|", view: favoriteButton)
        addConstraintsWithFormat("V:[v0(44)]|", view: shareButton)
        
//        addConstraintsWithFormat("H:|-65-[v0]|", view: locationButton)
        self.locationButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraintsWithFormat("V:[v0]-150-|", view: locationButton)
        addConstraintsWithFormat("V:[v0]-120-|", view: dateOfGameLabel)
        self.addConstraints([centerX, centerXDateLabel])
    }
    
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, view: UIView ...) {
        var viewsDict = [String: UIView]()
        for(index, view) in view.enumerate() {
            let key = "v\(index)"
            viewsDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}