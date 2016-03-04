//
//  RivalChooseSportVC.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/3/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class RivalChooseSportVC: UIViewController {
    
    var labelToPass:String!
    var imageToPass:UIImage!
    
    @IBOutlet weak var footballImage: UIButton!
    @IBOutlet weak var tennisImage: UIButton!
    @IBOutlet weak var soccerImage: UIButton!
    @IBOutlet weak var basketballImage: UIButton!
    @IBOutlet weak var frisbeeImage: UIButton!
    @IBOutlet weak var baseballImage: UIButton!
    @IBOutlet weak var badmintonImage: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        let badmintonCenter = badmintonImage.center
        let soccerCenter = soccerImage.center
        let baseballCenter = baseballImage.center
        let tennisCenter = tennisImage.center
        let frisbeeCenter = frisbeeImage.center
        let basketballCenter = basketballImage.center
        let footballCenter = footballImage.center
        
        badmintonImage.center.x = self.view.frame.width - 30
        soccerImage.center.x = self.view.frame.width - 30
        baseballImage.center.y = self.view.frame.height - 30
        tennisImage.center.y = self.view.frame.height - 30
        frisbeeImage.center.y = self.view.frame.height - 30
        basketballImage.center.x = self.view.frame.width + 30
        footballImage.center.x = self.view.frame.width + 30
        badmintonImage.alpha = 0
        soccerImage.alpha = 0
        baseballImage.alpha = 0
        tennisImage.alpha = 0
        frisbeeImage.alpha = 0
        basketballImage.alpha = 0
        footballImage.alpha = 0
        
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6.0, options: UIViewAnimationOptions.CurveLinear, animations: ({
            self.badmintonImage.center.x = badmintonCenter.x
            self.baseballImage.center.y = baseballCenter.y
            self.basketballImage.center.x = basketballCenter.x
            self.soccerImage.center.x = soccerCenter.x
            self.tennisImage.center.y = tennisCenter.y
            self.footballImage.center.x = footballCenter.x
            self.frisbeeImage.center.y = frisbeeCenter.y
            self.badmintonImage.alpha = 1
            self.soccerImage.alpha = 1
            self.baseballImage.alpha = 1
            self.tennisImage.alpha = 1
            self.frisbeeImage.alpha = 1
            self.basketballImage.alpha = 1
            self.footballImage.alpha = 1
            
        }), completion: nil)

    }
    override func viewDidDisappear(animated: Bool) {
        badmintonImage.alpha = 0
        soccerImage.alpha = 0
        baseballImage.alpha = 0
        tennisImage.alpha = 0
        frisbeeImage.alpha = 0
        basketballImage.alpha = 0
        footballImage.alpha = 0
    }
    
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
    
//    override func viewWillAppear(animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//    }
//    
//    override func viewWillDisappear(animated: Bool)
//    {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBarHidden = false
//    }
    
    @IBAction func frisbeeClicked(sender: AnyObject) {
        labelToPass = "Frisbee"
        imageToPass = frisbeeImage.imageView?.image
        performSegueWithIdentifier("SportToRivalList", sender: self)
    }
    @IBAction func footballClicked(sender: AnyObject) {
        labelToPass = "Football"
        imageToPass = footballImage.imageView?.image
        performSegueWithIdentifier("SportToRivalList", sender: nil)
    }
    @IBAction func tennisClicked(sender: AnyObject) {
        labelToPass = "Tennis"
        imageToPass = tennisImage.imageView?.image
        performSegueWithIdentifier("SportToRivalList", sender: nil)
    }
    @IBAction func soccerClicked(sender: AnyObject) {
        labelToPass = "Soccer"
        imageToPass = soccerImage.imageView?.image
        performSegueWithIdentifier("SportToRivalList", sender: nil)
    }
    @IBAction func badmintonClicked(sender: AnyObject) {
        labelToPass = "Badminton"
        imageToPass = badmintonImage.imageView?.image
        performSegueWithIdentifier("SportToRivalList", sender: nil)
    }
    
    @IBAction func baseballClicked(sender: AnyObject) {
        labelToPass = "Baseball"
        imageToPass = baseballImage.imageView?.image
        performSegueWithIdentifier("SportToRivalList", sender: nil)
    }
    @IBAction func basketballClicked(sender: AnyObject) {
        labelToPass = "Basketball"
        imageToPass = basketballImage.imageView?.image
        performSegueWithIdentifier("SportToRivalList", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SportToRivalList" {
            let vc = segue.destinationViewController as! RivalListViewController
            vc.passedLabel = self.labelToPass
            vc.passedImage = self.imageToPass
        }
    }

}
