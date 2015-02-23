//
//  TweetPresenter.swift
//  twitter
//
//  Created by Josh Lubaway on 2/22/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class TweetPresenter: NSObject {
    var tweet: Tweet!

    init(tweet: Tweet) {
        self.tweet = tweet
    }

    func timeAgo() -> String {
        let date = tweet.createdAt
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

        return "\(number)\(label)"
    }
}
