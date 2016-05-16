//
//  RecentActivityCell.swift
//  SquadUp-iOS
//
//  Created by Adam Sloma on 5/15/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class RecentActivityCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var numPeopleLabel: UILabel!
    
    func configureCell(game: LobbyGameModel) {
        if game.registered == "yes" {
            sportImage.image = UIImage(named: "sponsorIcon.png")
        }
        titleLabel.text = game.lobbyName + " " + game.sport
        numPeopleLabel.text = String(game.currentCapacity) + " /" + " " + String(game.maxCapacity)
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
