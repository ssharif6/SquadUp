//
//  RivalsMessagesViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 3/8/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase

class RivalsMessagesViewController: UIViewController {
    
    var idArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
    }
    func parseData() {
        DataService.ds.REF_USER_CURRENT.childByAppendingPath("rivals").observeEventType(.Value, withBlock: { snapshot in
            var asdf = [String]()

            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let rivalsDict = snap.value as? Dictionary<String, AnyObject> {
                        let value = snap.value as! String
                        print(value)
                        print("DUCK FUCKER")
                        asdf.append(value)
                        
                    }
                }
            }
            self.idArray = asdf
        })
    }

    
}
