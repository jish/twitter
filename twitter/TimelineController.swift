//
//  TimelineController.swift
//  twitter
//
//  Created by Josh Lubaway on 2/21/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class TimelineController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance.fetchHomeTimeline() { (tweets, error) in
            if let t = tweets {
                println("Received \(t.count) tweets from home timeline")
                for tweet in t {
                    println("\(tweet.createdAt) \(tweet.user.name): (@\(tweet.user.screenName)) \(tweet.text)")
                }
            } else {
                println("Error retreiving home timeline: \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: UIButton) {
        println("Logout requested")
        User.logout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
