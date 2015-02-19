//
//  TwitterClient.swift
//  twitter
//
//  Created by Josh Lubaway on 2/18/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

let consumerKey = "biYAqubJD0rK2cRatIQTZw"
let consumerSecret = "2cygl2irBgMQVNuWJwMn6vXiyDnWtht7gSyuRnf0Fg"
let baseUrl = NSURL(string: "https://api.twitter.com")!

class TwitterClient: BDBOAuth1RequestOperationManager {
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: baseUrl, consumerKey: consumerKey, consumerSecret: consumerSecret)
        }

        return Static.instance
    }
}
