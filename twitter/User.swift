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
    let profileImageUrl: NSURL
    let bannerImageUrl: NSURL?
    let bio: String

    init(dict: NSDictionary) {
        let profileImageString = (dict["profile_image_url_https"] as String).stringByReplacingOccurrencesOfString("_normal.png", withString: "_bigger.png")

        if let bannerImageString = dict["profile_banner_url"] as? String {
            bannerImageUrl = NSURL(string: bannerImageString)!
        }

        name = dict["name"] as String
        screenName = dict["screen_name"] as String
        profileImageUrl = NSURL(string: profileImageString)!
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
