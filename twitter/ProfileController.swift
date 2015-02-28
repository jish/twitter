//
//  ProfileController.swift
//  twitter
//
//  Created by Josh Lubaway on 2/26/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    var user: User!

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        photoView.layer.cornerRadius = 5
        photoView.clipsToBounds = true
        
        photoView.layer.borderColor = UIColor.blackColor().CGColor
        photoView.layer.borderWidth = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        nameLabel.text = user.name
        handleLabel.text = "@\(user.screenName)"
        bannerImageView.setImageWithURL(user.bannerImageUrl)
        photoView.setImageWithURL(user.profileImageUrl)
        followersLabel.text = String(user.followers)
        followingLabel.text = String(user.following)
        tweetCountLabel.text = String(user.numTweets)
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
