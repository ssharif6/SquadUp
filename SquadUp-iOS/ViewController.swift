//
//  ViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/23/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON
import Alamofire

var facebookLogin = FBSDKLoginManager()

var CURRENT_USER: UserModel!

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    var usersArray: [UserModel]!
    
    // User Logged In Fields
    var fullName: String! = ""
    var profileImageUrl: String! = ""
    var firstName: String! = ""
    var lastName: String! = ""
    var genderString: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        emailField.layer.borderColor = UIColor.clearColor().CGColor
        emailField.layer.borderWidth = 0
        passwordField.delegate = self
        passwordField.layer.borderColor = UIColor.clearColor().CGColor
        passwordField.layer.borderWidth = 0
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.setTabBarVisible(false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            if NSUserDefaults.standardUserDefaults().valueForKey(SELECTED_SPORTS) != nil {
                self.performSegueWithIdentifier("loginToFeedSportsBypassed", sender: nil)
            } else {
                self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
            }
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func facebookButtonPressed(sender: UIButton!) {
        facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            if facebookError != nil {
                print("Facebook Error \(facebookError.description)")
                // Maybe put a pop up notification
                
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Facebook Login Successful")
                // Perform Authentication
                self.fetchProfile()
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, AuthData in
                    
                    if error != nil {
                        print("Login Failed")
                        
                    } else {
                        print("Logged in")
                        // Create Firebase User
                        // TODO: Find Post History for Facebook User
                        
                        // User Information
                        
                        
                        
                        let posts = []
                        let sports = []
                        var notifications = [Dictionary<String, AnyObject>]()
                        
                        let notification1: Dictionary<String, AnyObject> = [
                            "notificationMessage": "Renee has challenged you!",
                            "notificationType": "Challenge",
                            "sentFromID": "0111ce31-04c5-4213-8b62-af233bb3b629",
                            "sportChallenge": "Tennis"
                        ]
                        let notification2: Dictionary<String, AnyObject> = [
                            "notificationMessage": "Douglas has challenged you!",
                            "notificationType": "Challenge",
                            "sentFromID": "06f11c84-c68e-43a6-99c0-cde53399946f",
                            "sportChallenge": "Basketball"
                        ]
                        let notification6: Dictionary<String, AnyObject> = [
                            "notificationMessage": "Tommie has challenged you!",
                            "notificationType": "Challenge",
                            "sentFromID": "0b11d418-285b-4b3a-aadd-04d57ec98043",
                            "sportChallenge": "Soccer"
                        ]
                        let notification4: Dictionary<String, AnyObject> = [
                            "notificationMessage": "Calvin has challenged you!",
                            "notificationType": "Challenge",
                            "sentFromID": "100d0a06-5791-4865-96bf-3682dcd7922d",
                            "sportChallenge": "Badminton"
                        ]
                        let notification5: Dictionary<String, AnyObject> = [
                            "notificationMessage": "Eunice has challenged you!",
                            "notificationType": "Challenge",
                            "sentFromID": "184fa9ac-3924-4f31-befe-b68efee57472",
                            "sportChallenge": "Tennis"
                        ]
                        let notification3: Dictionary<String, AnyObject> = [
                            "notificationMessage": "Ted has sent you a Friend Request!",
                            "notificationType": "friendRequest",
                            "sentFromID": "d3d9d8ff-10d7-4476-adcf-23af9c8ebb42",
                            "sportChallenge": "None"
                        ]
                        
                        notifications.append(notification1)
                        notifications.append(notification2)
                        notifications.append(notification3)
                        notifications.append(notification4)
                        notifications.append(notification5)
                        notifications.append(notification6)
                        
                        var recentActivity = [String]()
                        recentActivity.append("game10")
                        recentActivity.append("game11")
                        var rivals = [String]()
                        rivals.append("")
                        let facebookID = AuthData.providerData["id"]
                        let profileImageUrlUser = AuthData.providerData["profileImageURL"]
                        print(profileImageUrlUser)
                        
                        let user = ["provider": AuthData.provider!, "id": "user", "rating": "5", "gender": self.genderString, "firstName": self.firstName,"lastName": self.lastName, "posts": "hullo","profileImageUrl": self.profileImageUrl, "notifications": notifications, "recentActivity": recentActivity, "rivals": rivals, "messages": [""]]
                        let currentUser: UserModel = UserModel(key: AuthData.uid, firstName: self.firstName, lastName: self.lastName, gender: self.genderString, userId: facebookID as! String, posts: posts as! [String], sports: sports as! [String], rating: "5", profileImageUrl: self.profileImageUrl, recentActivity: recentActivity, rivals: rivals, messages: [""])
                        
                        CURRENT_USER = currentUser
                        let defaults = NSUserDefaults.standardUserDefaults()
                        let UserModelKey = "userModelKey"
                        let currentUserData = NSKeyedArchiver.archivedDataWithRootObject(currentUser)
                        defaults.setObject(currentUserData, forKey: UserModelKey)
                        
                        DataService.ds.createFirebaseUser(AuthData.uid, user: user as! Dictionary<String, AnyObject>)
                        NSUserDefaults.standardUserDefaults().setValue(AuthData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier("LoggedIn", sender: nil)
                    }
                    
                })
            }
        }
        
    }
    
    // For email
    @IBAction func attemptLogin(sender: UIButton!) {
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, Authdata in
                if error != nil {
                    print(error.code)
                    
                    if error.code == STATUS_ACCOUNT_NON_EXIST {
                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
                            // Print Error Codes
                            if error != nil {
                                self.showErrorAlert("Could not Create Account", msg: "Problem Creating Account")
                                // Possible cases
                                // Invalid password, Already exists, incorrect email
                            } else {
                                NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                
                                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, AuthData in
                                    let user = ["provider": AuthData.provider!, "Blah": "Emailtest"]
                                    DataService.ds.createFirebaseUser(AuthData.uid, user: user)
                                })
                                self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
                            }
                        })
                    } else {
                        self.showErrorAlert("Could Not LogIn", msg: "Please check your Username or Password")
                    }
                }
                else {
                    self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
                }
            })
            
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an Email and Password")
        }
    }
    
    func fetchProfile() {
        // Fetches information for Facebook
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            if error != nil {
                print(error)
                return
            }
//            let email = result["email"] as? String
            let firstName = result["first_name"] as? String
            self.firstName = firstName
            let lastName = result["last_name"] as? String
            self.lastName = lastName
            self.fullName = firstName! + " " + lastName!
            if let gender = result["gender"] as? String {
                self.genderString = gender
            }
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                self.profileImageUrl = url
            }
        }
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
}
extension UITabBarController {
    
    func setTabBarVisible(visible:Bool, animated:Bool) {
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // animate the tabBar
        UIView.animateWithDuration(animated ? 0.3 : 0.0) {
            self.tabBar.frame = CGRectOffset(frame, 0, offsetY)
            self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }
}
