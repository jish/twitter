//
//  TimelineController.swift
//  twitter
//
//  Created by Josh Lubaway on 2/21/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class TimelineController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0

        TwitterClient.sharedInstance.fetchHomeTimeline() { (tweets, error) in
            if let t = tweets {
                println("Received \(t.count) tweets from home timeline")
                for tweet in t {
                    println("\(tweet.createdAt) \(tweet.user.name): (@\(tweet.user.screenName)) \(tweet.text)")
                }
                self.tweets = t
                self.tableView.reloadData()
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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("tweet-cell") as TweetCell
        let tweet = tweets[indexPath.row]

        cell.hydrate(tweet)

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
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
