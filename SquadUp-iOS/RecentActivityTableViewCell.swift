//
//  RecentActivityTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/6/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class RecentActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var numPeopleTable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(game: LobbyGameModel) {
        if game.registered == "yes" {
            backgroundImage.image = UIImage(named: "sponsorBox.png")
            sportImage.image = UIImage(named: "sponsorIcon.png")
        } else {
            backgroundImage.image = UIImage(named: "normalBox.png")
        }
        titleLabel.text = game.lobbyName + " " + game.sport
        numPeopleTable.text = String(game.currentCapacity) + " /" + " " + String(game.maxCapacity)
        dateLabel.text = configureDate(game.date)
        dateLabel.textAlignment = .Right
        
    }
    
    func configureDate(dateString: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let convertedDate = dateFormatter.dateFromString(dateString)
        let dateConverted = dateFormatter.stringFromDate(convertedDate!)
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: convertedDate!)
        let weekDay = myComponents.weekday
        let daysOfWeek = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
        return daysOfWeek[weekDay - 1]
    }

}
