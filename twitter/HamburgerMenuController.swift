//
//  HamburgerMenuController.swift
//  twitter
//
//  Created by Josh Lubaway on 2/24/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class HamburgerMenuController: UIViewController {

    var panOffset: CGPoint!

    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        println(containerView.center)
        containerView.center = CGPoint(x: view.center.x, y: view.center.y)
        println(containerView.center)
    }

    override func viewWillAppear(animated: Bool) {
        

        println(containerView.center)
        containerView.center = CGPoint(x: view.center.x, y: view.center.y)
        println(containerView.center)

        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTimelineTap(sender: UIButton) {
        println("Timeline")
    }

    @IBAction func onLogoutTap(sender: UIButton) {
        println("Logout")
    }

    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        let view = sender.view!
        let panLocation = sender.locationInView(self.view)

        if sender.state == .Began {
            panOffset = CGPoint(x: view.center.x - panLocation.x, y: view.center.y - panLocation.y)
        } else if sender.state == .Changed {
            UIView.animateWithDuration(0.1, animations: {
                view.center = CGPoint(x: panLocation.x + self.panOffset.x, y: view.center.y)
            })
            println(panLocation)
        } else if sender.state == .Ended {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: nil, animations: {
                    let percent = panLocation.x / self.view.frame.width
                    println(percent)
                
                    if percent < 0.6 {
                        view.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
                    } else {
                        view.center = CGPoint(x: self.view.center.x + self.view.frame.width - 64, y: self.view.center.y)
                    }
                
                }, completion: { (success) in })
            panOffset = nil
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
