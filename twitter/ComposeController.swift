//
//  ComposeController.swift
//  twitter
//
//  Created by Josh Lubaway on 2/22/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class ComposeController: UIViewController {

    @IBOutlet weak var composeTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSubmitTweet(sender: AnyObject) {
        let status = composeTextView.text
        println("Submit tweet requested \(status)")

        TwitterClient.sharedInstance.submitTweet(composeTextView.text) { (response, error) in
            if let r = response as? NSDictionary {
                println("Tweeted \(r)")
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                println("Error tweeting \(error)")
            }
        }
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
