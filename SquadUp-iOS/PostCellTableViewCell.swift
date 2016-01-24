//
//  PostCellTableViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 1/23/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import Alamofire

class PostCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var numLikes: UILabel!
    
    var post: Post!
    var request = Request?()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func drawRect(rect: CGRect) {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
    }

    func configureCell(post: Post, image: UIImage?) {
        self.post = post
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
        
    }

}
