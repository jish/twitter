//
//  TweetDetailController.swift
//  twitter
//
//  Created by Josh Lubaway on 2/22/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class TweetDetailController: UIViewController {

    var tweet: Tweet!

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleView: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeAgo: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        hydrate(tweet)
    }

    func hydrate(tweet: Tweet) {
        let presenter = TweetPresenter(tweet: tweet)

        nameLabel.text = tweet.authorName
        handleView.text = "@\(tweet.authorHandle)"
        tweetLabel.text = tweet.text
        photoView.setImageWithURL(tweet.authorPhotoUrl)
        timeAgo.text = presenter.timeAgo()
    }

    @IBAction func onRetweetPressed(sender: AnyObject) {
        println("Retweet pressed \(tweet.id)")
        TwitterClient.sharedInstance.retweet(tweet.id) { (response, error) in
            if let r = response as? NSDictionary {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                println("Error retweeting \(self.tweet.id) \(error)")
            }
        }
    }

    @IBAction func onFavoritePressed(sender: AnyObject) {
        println("Favorite pressed \(tweet.id)")
    }

    @IBAction func onReplyPressed(sender: AnyObject) {
        println("Reply pressed \(tweet.id)")
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
