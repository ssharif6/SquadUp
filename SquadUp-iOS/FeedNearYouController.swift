//
//  FeedNearYouController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 4/14/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class FeedNearYouController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var CellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Events Near You"
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.lightGrayColor()
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: CellId)
        navigationController?.navigationBar.tintColor = UIColor.rgb(0, green: 171, blue: 236)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(CellId, forIndexPath: indexPath) as! FeedCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 400)
    }
    
    
    // Inverting
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

class FeedCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .ScaleAspectFit
//        imageView.backgroundColor = UIColor.redColor()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 2
//        let attributedText = NSMutableAttributedString(string: "Mark Zuckerburg", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)])
//        
//        attributedText.appendAttributedString(NSAttributedString(string: "\nDecmber 18th San Fransisco", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
//        label.attributedText = attributedText
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 4
//        
//        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
//        
//        label.font = UIFont.boldSystemFontOfSize(14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    let sportLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Tennis", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(22)])
        attributedText.appendAttributedString(NSAttributedString(string: "\n2016-04-15 Fri at 6:10", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14), NSForegroundColorAttributeName: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        label.attributedText = attributedText
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "0.9 Mi"
        label.font = UIFont(name: "Arial", size: 14)
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
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let numPeopleGoingLabel: UILabel = {
        let label = UILabel()
        label.text = "21 People Going  37 Comments"
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.rgb(155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
        return view
    }()
    
    //MARK: Buttons
    
    let joinButton = FeedCell.buttonForTitle("Join", imageName: "tennisJoinIconSmall")
    let commentButton = FeedCell.buttonForTitle("Comment", imageName: "messageIconSmall")
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
        button.titleLabel!.font = UIFont(name: "Arial", size: 14)
        button.setNeedsLayout()
        button.setTitleColor(UIColor.rgb(143, green: 150, blue: 162), forState: .Normal)
        button.setImage(UIImage(named: "mapIconSmall-1"), forState: .Normal)
        return button
    }()
    
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        addSubview(sportInformationTextView)
        addSubview(sportBackgroundImageView)
        addSubview(numPeopleGoingLabel)
        addSubview(dividerLineView)
        addSubview(joinButton)
        addSubview(commentButton)
        addSubview(shareButton)
        addSubview(sportLabel)
        addSubview(distanceLabel)
        addSubview(locationButton)
        
//        addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1]|", view: profileImageView, nameLabel)
//        addConstraintsWithFormat("V:|-8-[v0]", view: nameLabel)
        addConstraintsWithFormat("H:|-8-[v0]|", view: sportLabel)
        addConstraintsWithFormat("V:|-8-[v0]", view: sportLabel)
        addConstraintsWithFormat("H:[v0]-8-|", view: distanceLabel)
        addConstraintsWithFormat("V:|-28-[v0]", view: distanceLabel)
        addConstraintsWithFormat("H:|-8-[v0]-8-|", view: sportBackgroundImageView)
        addConstraintsWithFormat("V:|-52-[v0(44)]-4-[v1]-8-[v2(24)]-6-[v3(0.9)][v4(44)]|", view: sportInformationTextView, sportBackgroundImageView, numPeopleGoingLabel, dividerLineView, joinButton)
        addConstraintsWithFormat("H:|-8-[v0]-4-|", view: sportInformationTextView)
        addConstraintsWithFormat("H:|-12-[v0]-12-|", view: numPeopleGoingLabel)
        addConstraintsWithFormat("H:|-12-[v0]-12-|", view: dividerLineView)
        
        // Button Constraints
        addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", view: joinButton, commentButton, shareButton)
        addConstraintsWithFormat("V:[v0(44)]|", view: commentButton)
        addConstraintsWithFormat("V:[v0(44)]|", view: shareButton)
        addConstraintsWithFormat("H:[v0]-8-|", view: locationButton)
        addConstraintsWithFormat("V:|-8-[v0]", view: locationButton)



        

        
    }
    
    // Parse Firebase Data here
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