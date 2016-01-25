//
//  RivalCollectionViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/24/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class RivalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell() {
        profileImage.contentMode = UIViewContentMode.ScaleAspectFit
    }
}
