//
//  FindGameVC.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/30/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class FindGameVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sportsTableView: UITableView!
    @IBOutlet weak var chooseSportView: UIView!

    var labelToPass:String!
    var imageToPass:UIImage!
    
    var sportCategories = ["Badminton", "Baseball", "Basketball", "Football", "Soccer", "Tennis", "Ultimate Frisbee"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsTableView.delegate = self
        sportsTableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportCategories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("sportCell", forIndexPath: indexPath) as! SportCell
        let sport = sportCategories[indexPath.row]
        cell.configureCell(sport)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! SportCell
        labelToPass = currentCell.sportLabel.text
        imageToPass = currentCell.sportImage.image
        performSegueWithIdentifier("sportSelected", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sportSelected" {
            let vc = segue.destinationViewController as! SportViewController
            vc.passedLabel = self.labelToPass
            vc.passedImage = self.imageToPass
        }
    }
    
}
