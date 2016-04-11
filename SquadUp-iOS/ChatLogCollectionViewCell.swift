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
        textView.font = UIFont.systemFontOfSize(16)
        textView.text = "Sample Message"
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        addSubview(messageTextView)
        addConstraintsWithFormat("H:|[v0]|", views: messageTextView)
        addConstraintsWithFormat("V:|[v0]|", views: messageTextView)
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
