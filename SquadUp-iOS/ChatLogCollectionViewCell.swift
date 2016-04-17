//
//  ChatLogCollectionViewCell.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 4/10/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit

class ChatLogCollectionViewCell: UICollectionViewCell {
    
    var messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clearColor()
        textView.font = UIFont.systemFontOfSize(16)
        textView.textColor = UIColor.whiteColor()
        textView.text = "Sample Message"
        return textView
    }()
    
    let textBubbleView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.rgb(2, green: 143, blue: 204)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        addConstraintsWithFormat("H:|-8-[v0(30)]", view: profileImageView)
        addConstraintsWithFormat("V:[v0(30)]|", view: profileImageView)
        profileImageView.backgroundColor = UIColor.redColor()
    }
    
    
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDict = [String: UIView]()
        for(index, view) in views.enumerate() {
            let key = "v\(index)"
            viewsDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}
