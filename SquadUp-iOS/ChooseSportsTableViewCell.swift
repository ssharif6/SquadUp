//
//  ChooseSportsTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/21/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class ChooseSportsTableViewCell: UITableViewCell {

    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!
    var sportCategories = ["Basketball", "Badminton", "Baseball", "Football", "Soccer", "Tennis", "Ultimate Frisbee"]
    
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
            sportImage.image = UIImage(named: "Basketball")
        } else if (sport == "Soccer") {
            sportLabel.text = sport
            sportImage.image = UIImage(named: "Soccer")
        } else if (sport == "Tennis") {
            sportLabel.text = sport
            sportImage.image = UIImage(named: "Tennis")
        } else if (sport == "Baseball") {
            sportLabel.text = sport
            sportImage.image = UIImage(named: "Baseball")
        } else if (sport == "Football") {
            sportLabel.text = sport
            sportImage.image = UIImage(named: "Football")
            sportImage.contentMode = UIViewContentMode.ScaleToFill
        } else if (sport == "Badminton") {
            sportLabel.text = sport
            sportImage.image = UIImage(named: "Badminton")
        } else if (sport == "Frisbee") {
            sportLabel.text = sport
            sportImage.image = UIImage(named: "Frisbee")
            // Set an image for Frisbee
        }
    }
    
    


    

}
