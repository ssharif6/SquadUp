//
//  ChooseSportNotificationViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/17/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class ChooseSportNotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sportTableView: UITableView!
    
    var sportCategories = ["Badminton", "Baseball", "Basketball", "Football", "Soccer", "Tennis", "Ultimate Frisbee"]
    var selectedSports: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        sportTableView.delegate = self
        sportTableView.dataSource = self
        sportTableView.allowsMultipleSelection = true

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sportCell", forIndexPath: indexPath) as! ChooseSportsTableViewCell
        let sport = sportCategories[indexPath.row]
        cell.configureCell(sport)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportCategories.count
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChooseSportsTableViewCell
        if cell.accessoryType == UITableViewCellAccessoryType.None {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

    }
    
    @IBAction func donePressed(sender: AnyObject) {
        // POST TO FIREBASE
        for cell in sportTableView.visibleCells {
            if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
                let indexPath = sportTableView.indexPathForCell(cell)?.row
                selectedSports.append(sportCategories[indexPath!])
            }
        }
        let sportsRef = DataService.ds.REF_USER_CURRENT.childByAppendingPath("sports")
        sportsRef.setValue(selectedSports)
        print(selectedSports)
        NSUserDefaults.standardUserDefaults().setValue(selectedSports, forKey: SELECTED_SPORTS)
        performSegueWithIdentifier("sportsPageToFeed", sender: nil)
    }


}
