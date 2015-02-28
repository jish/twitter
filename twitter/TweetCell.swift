//
//  TweetCell.swift
//  twitter
//
//  Created by Josh Lubaway on 2/22/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

protocol ProfileTapDelegate {
    func onTappedPhoto(user: User)
}

class TweetCell: UITableViewCell {

    var user: User!
    var delegate: ProfileTapDelegate!

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
        let presenter = TweetPresenter(tweet: tweet)

        user = tweet.user

        nameLabel.text = tweet.authorName
        handleLabel.text = "@\(tweet.authorHandle)"
        tweetLabel.text = tweet.text
        photoView.setImageWithURL(tweet.authorPhotoUrl)
        timeAgoLabel.text = presenter.timeAgo()

        let gr = UITapGestureRecognizer(target: self, action: "onTapPhoto")
        photoView.addGestureRecognizer(gr)
    }

    func onTapPhoto() {
        println("onTapPhoto \(user)")
        delegate.onTappedPhoto(user)
    }
}
