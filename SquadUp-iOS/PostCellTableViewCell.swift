//
//  PostCellTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/23/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var numLikes: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    var post: Post!
    var request = Request?()
    var likeRef: Firebase!
    var cache = NSCache()


    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:")
        tap.numberOfTapsRequired = 1
        likeImage.addGestureRecognizer(tap)
        likeImage.userInteractionEnabled = true
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.contentMode = UIViewContentMode.ScaleAspectFit

    }


    func configureCell(post: Post, image: UIImage?) {
        if (cache.objectForKey("cachedCell") != nil) {
            // load from Cached Version
        } else {
            // Load and send to Cache
            self.post = post
            likeRef = DataService.ds.REF_USER_CURRENT.childByAppendingPath("likes").childByAppendingPath(post.postKey)
            self.nameLabel.text = post.name
            self.activityLabel.text = post.activity
            self.numLikes.text = "\(post.numLikes)"
            
            if post.imageUrl != nil {
                if image != nil {
                    self.profileImage.image = image
                } else {
                    request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, error in
                        if error == nil {
                            let image = UIImage(data: data!)!
                            self.profileImage.image = image
                            FeedVCViewController.imageCache.setObject(image, forKey: self.post.imageUrl!)
                        }
                    })
                }
            }
            // Reference for likes
            
            likeRef.observeSingleEventOfType(.Value, withBlock:{snapshot in
                if let doesNotExist = snapshot.value as? NSNull {
                    // Post is not liked
                    self.likeImage.image = UIImage(named: "heart-empty")
                } else {
                    self.likeImage.image = UIImage(named: "heart-full")
                }
            })
            
            cache.setObject("Cached", forKey: "cachedCell")
            cache.setObject(post, forKey: "cachedPost")
            cache.setObject(post.name, forKey: "cachedPostName")
            cache.setObject(post.activity, forKey: "cachedActivity")
            cache.setObject(post.numLikes, forKey: "cachedNumLikes")
            cache.setObject(post.imageUrl!, forKey: "cachedImageUrl")
            
        }
        
        
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        likeRef.observeSingleEventOfType(.Value, withBlock:{snapshot in
            if let doesNotExist = snapshot.value as? NSNull {
                // Post is not liked
                self.likeImage.image = UIImage(named: "heart-full")
                self.post.adjustLikes(true) // add like
                self.likeRef.setValue(true) // References specific post
            } else {
                self.likeImage.image = UIImage(named: "heart-empty")
                self.post.adjustLikes(false) // remove like
                self.likeRef.removeValue() // removes value AND key
            }
        })
    }

}
