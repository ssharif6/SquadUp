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
    var sportCategories = ["Badminton", "Baseball", "Basketball", "Football", "Soccer", "Tennis"]
    
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

}
