//
//  ViewController.swift
//  twitter
//
//  Created by Josh Lubaway on 2/18/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: UIButton) {
        println("login requested")

        TwitterClient.sharedInstance.login() { (user, error) in
            if let u = user {
                println("Logged in user: \(u.name) (@\(u.screenName))")
                self.performSegueWithIdentifier("timeline-segue", sender: self)
            } else {
                println("Error logging in: \(error)")
            }
        }
    }

}

