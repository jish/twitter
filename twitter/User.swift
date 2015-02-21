//
//  User.swift
//  twitter
//
//  Created by Josh Lubaway on 2/21/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class User: NSObject {
    let name: String
    let screenName: String
    let profileImage: NSURL
    let bio: String
    let dict: NSDictionary

    init(name: String, screenName: String, profileImage: String, bio: String) {
        self.name = name
        self.screenName = screenName
        self.profileImage = NSURL(string: profileImage)!
        self.bio = bio
        self.dict = [:]
    }

    init(dict: NSDictionary) {
        name = dict["name"] as String
        screenName = dict["screen_name"] as String
        profileImage = NSURL(string: dict["profile_image_url_https"] as String)!
        bio = dict["description"] as String

        self.dict = dict
    }
}
