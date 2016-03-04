//
//  PostCellView.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/25/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class PostCellView: UIView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 25
        layer.shadowColor = UIColor.whiteColor().CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 1.0
        layer.shadowOffset = CGSizeMake(0, 2.0)
        clipsToBounds = false
    }
    
        
}
