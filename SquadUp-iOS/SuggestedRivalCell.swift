//
//  SuggestedRivalCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 4/11/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class SuggestedRivalCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let cellId = "cellId"
    let suggestedRivalsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .Horizontal

        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.clearColor()
        addSubview(suggestedRivalsCollectionView)
        suggestedRivalsCollectionView.dataSource = self
        suggestedRivalsCollectionView.delegate = self
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": suggestedRivalsCollectionView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": suggestedRivalsCollectionView]))
        suggestedRivalsCollectionView.registerClass(SuggestedRivalIndividualCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SuggestedRivalIndividualCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(150, 150)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 8, 0, 8)
    }
}

class SuggestedRivalIndividualCell: UICollectionViewCell {
    // This is the individual Cell in the CollectionView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Steph Curry"
        label.numberOfLines = 2
        label.font = UIFont.systemFontOfSize(12)
//        label.textColor = UIColor.whiteColor()
        return label
    }()
    
    
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "Steph")
        iv.contentMode = .ScaleAspectFit
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        imageView.frame = CGRectMake(0, 0, frame.width, frame.width)
        nameLabel.frame = CGRectMake(0, frame.width + 2, frame.width, 150)
        
    }

}