//
//  SportCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/30/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class SportCell: UITableViewCell {
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var sportImage: UIImageView!
    var sportCategories = ["Basketball", "Badminton", "Baseball", "Football", "Soccer", "Tennis"]

    override func awakeFromNib() {
        super.awakeFromNib()
        
        sportImage.layer.borderWidth = 1
        sportImage.layer.masksToBounds = false
        sportImage.layer.borderColor = UIColor.blackColor().CGColor
        sportImage.layer.cornerRadius = sportImage.frame.height/2
        sportImage.clipsToBounds = true
    }

    
    func configureCell(sport: String!) {
        if(sport == "Basketball") {
            //Put basketball image
            sportLabel.text = sport
            sportImage.image = UIImage(named: "basketballAndWhistle")
        } else if (sport == "Soccer") {
            sportLabel.text = sport
            sportImage.image = UIImage(named: "soccerTableView")
        } else if (sport == "Tennis") {
            sportLabel.text = sport
        } else if (sport == "Baseball") {
            sportLabel.text = sport
        } else if (sport == "Football") {
            sportLabel.text = sport
        } else if (sport == "Badminton") {
            sportLabel.text = sport
        }
    }
    
    

}
