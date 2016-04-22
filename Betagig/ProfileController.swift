//
//  ProfileController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import AWSCore


class ProfileController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if AmazonCognitoManager.sharedInstance.isLoggedIn() {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            AmazonCognitoManager.sharedInstance.resumeSession {
                (task) -> AnyObject! in
                dispatch_async(dispatch_get_main_queue()) {
                    
                }
                return nil
            }
        } else {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : LoginController = storyboard.instantiateViewControllerWithIdentifier("loginModalController") as! LoginController
            self.tabBarController?.presentViewControllerFromVisibleViewController(vc, animated: true)
        }
    }
  
    @IBAction func logOut(sender: AnyObject) {
        AmazonCognitoManager.sharedInstance.logOut {
            (task) -> AnyObject! in
            dispatch_async(dispatch_get_main_queue()) {
                
                self.tabBarController?.selectedIndex = 0
                let firstNavController: UINavigationController = self.tabBarController?.selectedViewController as! UINavigationController;
                firstNavController.popToRootViewControllerAnimated(true)
            }
            return nil
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            self.performSegueWithIdentifier("paymentSegue", sender: nil)
        }
    }

}
