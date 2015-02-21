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

    func fetchAccessTokenWithQueryString(queryString: String, block: (BDBOAuth1Credential!, NSError?) -> Void) {
        let token = BDBOAuth1Credential(queryString: queryString)

        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: token,
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                self.requestSerializer.saveAccessToken(accessToken)
                block(accessToken, nil)
            }
        ) { (error: NSError!) -> Void in
            block(nil, error)
        }

    }
    
    func fetchHomeTimeline(block: ([Tweet], NSError?) -> Void) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (request, response) -> Void in
            println("Success")
            println(response)

            let tweets = map(response as Array) { (tweet: NSDictionary) -> Tweet in
                return Tweet(dict: tweet)
            } as [Tweet]

            block(tweets, nil)
        }, failure: { (request: AFHTTPRequestOperation!, error: NSError!) -> Void in
            block([Tweet](), nil)
        })
    }
}
