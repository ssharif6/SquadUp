//
//  ProfileViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/24/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var images: [String] = ["2011-11-07 21.04.01.jpg", "2011-11-07 21.04.01.jpg", "2011-11-07 21.04.01.jpg", "2011-11-07 21.04.01.jpg"]
    var tableData: [String] = ["Jay Jay", "Jay Jay", "Jay Jay", "Jay Jay"]
    
    @IBOutlet weak var rivalCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: RivalCollectionViewCell = (collectionView.dequeueReusableCellWithReuseIdentifier("rivalCollectionCell", forIndexPath: indexPath) as? RivalCollectionViewCell)!
        cell.configureCell()
        cell.nameLabel.text = tableData[indexPath.row]
        cell.profileImage.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Do something
    }
}