//
//  LoginMainController.swift
//  Betagig
//
//  Created by Nicki on 4/14/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit
import AWSCore

class LoginMainController: UIViewController{
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func loginWithFacebook(sender: AnyObject) {
        AmazonCognitoManager.sharedInstance.loginFromView(self, provider: "facebook", username: "", password: "") {
            (task: AWSTask!) -> AnyObject! in
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("authenticatedSegue", sender: nil)
            }
            return nil
        }

    }
    @IBAction func loginWithGoogle(sender: AnyObject) {
        AmazonCognitoManager.sharedInstance.loginFromView(self, provider: "google", username: "", password: "") {
            (task: AWSTask!) -> AnyObject! in
            dispatch_async(dispatch_get_main_queue()) {
                 self.performSegueWithIdentifier("authenticatedSegue", sender: nil)
            }
            return nil
        }
    }
   
    @IBAction func loginWithTwitter(sender: AnyObject) {
        AmazonCognitoManager.sharedInstance.loginFromView(self, provider: "twitter", username: "", password: "") {
            (task: AWSTask!) -> AnyObject! in
            dispatch_async(dispatch_get_main_queue()) {
               self.performSegueWithIdentifier("authenticatedSegue", sender: nil)  
            }
            return nil
        }
    }
}