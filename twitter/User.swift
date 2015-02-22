//
//  User.swift
//  twitter
//
//  Created by Josh Lubaway on 2/21/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "current_user_json"
let userLogoutEvent = "user_logout_event"

class User: NSObject {
    let name: String
    let screenName: String
    let profileImage: NSURL
    let bio: String

    init(name: String, screenName: String, profileImage: String, bio: String) {
        self.name = name
        self.screenName = screenName
        self.profileImage = NSURL(string: profileImage)!
        self.bio = bio
    }

    init(dict: NSDictionary) {
        name = dict["name"] as String
        screenName = dict["screen_name"] as String
        profileImage = NSURL(string: dict["profile_image_url_https"] as String)!
        bio = dict["description"] as String
    }

    class var currentUser: User? {
        if _currentUser == nil {
            if let data = defaults.objectForKey(currentUserKey) as? NSData {
                let dict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                _currentUser = User(dict: dict)
            }
        }

        return _currentUser
    }

    class var defaults: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }

    class func storeCurrentUserData(dict: NSDictionary) {
        let data = NSJSONSerialization.dataWithJSONObject(dict, options: nil, error: nil)

        defaults.setObject(data, forKey: currentUserKey)
        defaults.synchronize()
    }

    class func logout() {
        _currentUser = nil

        defaults.setObject(nil, forKey: currentUserKey)
        defaults.synchronize()

        TwitterClient.sharedInstance.logout()

        NSNotificationCenter.defaultCenter().postNotificationName(userLogoutEvent, object: nil)
    }
}
