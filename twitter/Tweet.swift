//
//  Tweet.swift
//  twitter
//
//  Created by Josh Lubaway on 2/21/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    let id: String
    let user: User
    let text: String
    let createdAtString: String
    let retweetCount: Int
    let favoritedCount: Int

    init(dict: NSDictionary) {
        id = dict["id_str"] as String
        user = User(dict: dict["user"] as NSDictionary)
        text = dict["text"] as String
        createdAtString = dict["created_at"] as String
        retweetCount = dict["retweet_count"] as Int
        favoritedCount = dict["favorite_count"] as Int
    }

    var createdAt: NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        return formatter.dateFromString(createdAtString)!
    }

    var authorName: String {
        return user.name
    }

    var authorHandle: String {
        return user.screenName
    }

    var authorPhotoUrl: NSURL {
        return user.profileImageUrl
    }
}
