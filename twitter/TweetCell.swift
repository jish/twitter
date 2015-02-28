//
//  TweetCell.swift
//  twitter
//
//  Created by Josh Lubaway on 2/22/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    var user: User!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var timeAgoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        photoView.layer.cornerRadius = 5
        photoView.clipsToBounds = true

        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.width
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func hydrate(tweet: Tweet) {
        user = tweet.user

        nameLabel.text = tweet.authorName
        handleLabel.text = "@\(tweet.authorHandle)"
        tweetLabel.text = tweet.text
        photoView.setImageWithURL(tweet.authorPhotoUrl)
        timeAgoLabel.text = timeAgo(tweet.createdAt)
    }
    
    func timeAgo(date: NSDate) -> String {
        var interval = -date.timeIntervalSinceNow
        var number = 0
        var label = ""

        if interval < 60 * 60 {
            number = Int(interval / 60)
            label = "m"
        } else if interval < 60 * 60 * 24 {
            number = Int(interval / 60 / 60)
            label = "h"
        } else if interval < 60 * 60 * 24 * 7 {
            number = Int(interval / 60 / 60 / 24)
            label = "d"
        } else {
            number = Int(interval / 60 / 60 / 24 / 7)
            label = "w"
        }

        let timeAgo = "\(number)\(label)"
        return timeAgo
    }
}
