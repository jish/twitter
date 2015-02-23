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
    var loginCallback: ((user: User?, error: NSError?) -> Void)?

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: baseUrl, consumerKey: consumerKey, consumerSecret: consumerSecret)
        }

        return Static.instance
    }

    func login(block: (user: User?, error: NSError?) -> Void) {
        self.loginCallback = block

        requestTokenWithCallback("cptwitterdemo://oauth") { (requestToken, error) in
            if let token = requestToken {
                println("Got the request token: \(token)")
                let authUrl = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token.token)")!
                UIApplication.sharedApplication().openURL(authUrl)
            } else {
                println("Error retrieving request token: \(error)")
                self.loginCallback!(user: nil, error: error)
            }
        }
    }

    func requestTokenWithCallback(callbackUrl: String, block: (BDBOAuth1Credential?, NSError?) -> Void) {
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

    func handleTwitterCallback(url: NSURL) {
        TwitterClient.sharedInstance.fetchAccessTokenWithQueryString(url.query!) { (accessToken, error) in
            if let token = accessToken {
                println("Got the access token")

                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil,
                    success: { (request: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        println("Fetching user succeeded, Twitter authentication success.")
                        let dict = response as NSDictionary
                        User.storeCurrentUserData(dict)
                        if let user = User.currentUser {
                            println("Logged in user: \(user.name) @\(user.screenName)")
                            self.loginCallback!(user: user, error: nil)
                        } else {
                            self.loginCallback!(user: nil, error: NSError())
                        }
                    }, failure: { (request: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("Error fetching user credentials \(error)")
                        self.loginCallback!(user: nil, error: error)
                    }
                )

            } else {
                println("Error retrieving access token: \(error)")
                self.loginCallback!(user: nil, error: error)
            }
        }
    }

    func fetchAccessTokenWithQueryString(queryString: String, block: (BDBOAuth1Credential?, NSError?) -> Void) {
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

    func fetchHomeTimeline(block: ([Tweet]?, NSError?) -> Void) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (request, response) -> Void in
            println("Fetched home timeline")
            println(response)

            let tweets = map(response as Array) { (tweet: NSDictionary) -> Tweet in
                return Tweet(dict: tweet)
            } as [Tweet]

            block(tweets, nil)
        }, failure: { (request: AFHTTPRequestOperation!, error: NSError!) -> Void in
            block(nil, error)
        })
    }

    func submitTweet(text: String, block: (AnyObject?, NSError?) -> Void) {
        let params = [
            "status": text
        ]

        POST("1.1/statuses/update.json", parameters: params, success: { (request, response) in
            block(response, nil)
        }, failure: { (request, error) in
            block(nil, error)
        })
    }

    func retweet(id: String, block: (AnyObject?, NSError?) -> Void) {
        let path = "1.1/statuses/retweet/\(id).json"
        POST(path, parameters: nil, success: { (request, response) in
            block(response, nil)
        }, failure: { (request, error) in
            block(nil, error)
        })
    }

    func favorite(id: String, block: (AnyObject?, NSError?) -> Void) {
        let params = [
            "id": id
        ]

        POST("1.1/favorites/create.json", parameters: params, success: { (request, response) in
            block(response, nil)
        }, failure: { (request, error) in
            block(nil, error)
        })
    }

    func logout() {
        requestSerializer.removeAccessToken()
    }
}
