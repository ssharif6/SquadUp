//
//  MoreSettingsTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/5/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class MoreSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var settingImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(label: String) {
        settingLabel.text = label
        settingLabel.textAlignment = .Left
    }


}
