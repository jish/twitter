//
//  TimelineController.swift
//  twitter
//
//  Created by Josh Lubaway on 2/21/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

let hamburgerTapEvent = "hamburger_tap_event"

class TimelineController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProfileTapDelegate {

    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    var delegate: HamburgerMenuController!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh:", forControlEvents: .ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        fetchHomeTimeline()
    }

    @IBAction func onTapProfileImage(sender: UITapGestureRecognizer) {
        println("Tap profile image \(sender)")
        println(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onHamburgerTap(sender: UIBarButtonItem) {
        println("Hamburger tap")
        NSNotificationCenter.defaultCenter().postNotificationName(hamburgerTapEvent, object: nil)
    }

    @IBAction func onLogout(sender: UIButton) {
        println("Logout requested")
        User.logout()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("tweet-cell") as TweetCell
        let tweet = tweets[indexPath.row]

        cell.hydrate(tweet)
        cell.delegate = self

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    func onRefresh(sender: AnyObject) {
        fetchHomeTimeline()
    }

    func fetchHomeTimeline() {
        TwitterClient.sharedInstance.fetchHomeTimeline() { (tweets, error) in
            if let t = tweets {
                println("Received \(t.count) tweets from home timeline")

                self.refreshControl.endRefreshing()

                self.tweets = t
                self.tableView.reloadData()
            } else {
                println("Error retreiving home timeline: \(error)")
            }
        }
    }

    func onTappedPhoto(user: User) {
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let profileController = storyBoard.instantiateViewControllerWithIdentifier("profile-controller") as ProfileController
        profileController.user = user
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("prepareForSegue \(segue.identifier)")

        if segue.identifier == "tweet-detail-segue" {
            println("Going to tweet")

            if let indexPath = tableView.indexPathForSelectedRow() {
                let tweet = tweets[indexPath.row]
                println("Tweet: \(tweet) \(tweet.authorName)")

                let vc = segue.destinationViewController as TweetDetailController
                vc.tweet = tweet
            }
        }
    }

}
