//
//  FindGameVC.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/30/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class FindGameVC: UIViewController {

    @IBOutlet weak var chooseSportView: UIView!
    

    var labelToPass:String!
    var imageToPass:UIImage!
    
    @IBOutlet weak var footballImage: UIButton!
    @IBOutlet weak var tennisImage: UIButton!
    @IBOutlet weak var soccerImage: UIButton!
    @IBOutlet weak var basketballImage: UIButton!
    @IBOutlet weak var frisbeeImage: UIButton!
    @IBOutlet weak var baseballImage: UIButton!
    @IBOutlet weak var badmintonImage: UIButton!
    var sportCategories = ["Badminton", "Baseball", "Basketball", "Football", "Soccer", "Tennis", "Ultimate Frisbee"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        badmintonImage.layer.borderColor = UIColor.blackColor().CGColor
        badmintonImage.layer.cornerRadius = badmintonImage.frame.height/2
        badmintonImage.clipsToBounds = true
        footballImage.layer.backgroundColor = UIColor.blackColor().CGColor
        footballImage.layer.cornerRadius = footballImage.frame.height / 2
        footballImage.clipsToBounds = true
        tennisImage.layer.borderColor = UIColor.blackColor().CGColor
        tennisImage.layer.cornerRadius = tennisImage.frame.height/2
        tennisImage.clipsToBounds = true
        soccerImage.layer.borderColor = UIColor.blackColor().CGColor
        soccerImage.layer.cornerRadius = soccerImage.frame.height/2
        soccerImage.clipsToBounds = true
        basketballImage.layer.borderColor = UIColor.blackColor().CGColor
        basketballImage.layer.cornerRadius = basketballImage.frame.height / 2
        basketballImage.clipsToBounds = true
        frisbeeImage.layer.borderColor = UIColor.blackColor().CGColor
        frisbeeImage.layer.cornerRadius = frisbeeImage.frame.height/2
        frisbeeImage.clipsToBounds = true
        baseballImage.layer.borderColor = UIColor.blackColor().CGColor
        baseballImage.layer.cornerRadius = baseballImage.frame.height/2
        baseballImage.clipsToBounds = true

        


    }
    
    @IBAction func frisbeeClicked(sender: AnyObject) {
        labelToPass = "Frisbee"
        imageToPass = frisbeeImage.imageView?.image
        performSegueWithIdentifier("sportSelected", sender: self)
    }
    @IBAction func footballClicked(sender: AnyObject) {
        labelToPass = "Football"
        imageToPass = footballImage.imageView?.image
        performSegueWithIdentifier("sportSelected", sender: nil)
    }
    @IBAction func tennisClicked(sender: AnyObject) {
        labelToPass = "Tennis"
        imageToPass = tennisImage.imageView?.image
        performSegueWithIdentifier("sportSelected", sender: nil)
    }
    @IBAction func soccerClicked(sender: AnyObject) {
        labelToPass = "Soccer"
        imageToPass = soccerImage.imageView?.image
        performSegueWithIdentifier("sportSelected", sender: nil)
    }
    @IBAction func badmintonClicked(sender: AnyObject) {
        labelToPass = "Badminton"
        imageToPass = badmintonImage.imageView?.image
        performSegueWithIdentifier("sportSelected", sender: nil)
    }
    
    @IBAction func baseballClicked(sender: AnyObject) {
        labelToPass = "Baseball"
        imageToPass = baseballImage.imageView?.image
        performSegueWithIdentifier("sportSelected", sender: nil)
    }
    @IBAction func basketballClicked(sender: AnyObject) {
        labelToPass = "Basketball"
        imageToPass = basketballImage.imageView?.image
        performSegueWithIdentifier("sportSelected", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sportSelected" {
            let vc = segue.destinationViewController as! SportViewController
            vc.passedLabel = self.labelToPass
            vc.passedImage = self.imageToPass
        }
    }
}
