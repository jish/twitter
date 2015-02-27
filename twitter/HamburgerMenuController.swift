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
    var myNavigationController: NavigationController!

    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        myNavigationController = storyBoard.instantiateViewControllerWithIdentifier("navigation-controller") as NavigationController
        displayViewController(myNavigationController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTimelineTap(sender: UIButton) {
        println("Timeline")
        myNavigationController.popToRootViewControllerAnimated(true)
        closeDrawer()
    }

    @IBAction func onProfileTap(sender: UIButton) {
        println("Profile")
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let profileController = storyBoard.instantiateViewControllerWithIdentifier("profile-controller") as ProfileController

        closeDrawer()
        myNavigationController.pushViewController(profileController, animated: true)
    }

    @IBAction func onLogoutTap(sender: UIButton) {
        println("Logout")
        User.logout()
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
            let percent = panLocation.x / self.view.frame.width

            if percent < 0.6 {
                closeDrawer()
            } else {
                openDrawer()
            }

            panOffset = nil
        }
    }

    func displayViewController(vc: UIViewController) {
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        addChildViewController(vc)
        vc.didMoveToParentViewController(self)
    }

    func closeDrawer() {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: nil, animations: {
            self.containerView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        }, completion: { (success) in })
    }

    func openDrawer() {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: nil, animations: {
            self.containerView.center = CGPoint(x: self.view.center.x + self.view.frame.width - 64, y: self.view.center.y)
        }, completion: { (success) in })
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
