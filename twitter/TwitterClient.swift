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

    func requestTokenWithCallback(callbackUrl: String, block: (BDBOAuth1Credential!, NSError?) -> Void) {
        requestSerializer.removeAccessToken()

        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: callbackUrl)!, scope: nil,
            success: { (requestToken: BDBOAuth1Credential!) in
                block(requestToken, nil)
            },
            failure: { (error: NSError!) -> Void in
                block(nil, error)
            }
        )
    }
}
