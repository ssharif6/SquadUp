//
//  FeedVCViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/23/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Firebase


class FeedVCViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    static var imageCache = NSCache()
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, -20, 0);
        

        // Downloading data with Firebase
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            self.posts = []
            // Parse Firebase Data
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    print("SNAP \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        if let cell: PostCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCellTableViewCell {
            
            cell.request?.cancel()
            
            var image: UIImage?
            
            if let url = post.imageUrl {
                image = FeedVCViewController.imageCache.objectForKey(url) as? UIImage
            }
            cell.configureCell(post, image: image)
            return cell

        } else {
            return PostCellTableViewCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = self.posts[indexPath.row]
        self.post = post
        performSegueWithIdentifier("FeedToProfile", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FeedToProfile" {
            let vc = segue.destinationViewController as! PublicProfileViewController
            vc.userPassed = self.post.id
            vc.imageUrlPassed = self.post.imageUrl
        }
    }

}
