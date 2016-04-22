//
//  MessagesController.swift
//  Betagig
//
//  Created by Melissa Hargis on 4/6/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit

class MessagesController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var closeBtn: UIButton!

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.backgroundView = UIImageView(image: UIImage(named: "vintage-typewriter"))
        mainTableView.tableFooterView = UIView(frame: CGRectZero)
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
            self.mainTableView.hidden = true
            let x: CGFloat = self.view.frame.size.width/2 - 321/2
            let y: CGFloat = self.view.frame.size.height/2 - 49/2
            let loginButton: UIButton = UIButton(frame: CGRect(x: x, y: y, width: 321, height: 49))
            
            loginButton.backgroundColor = UIColor(hexString: "E65100")
            loginButton.setTitle("Login or Sign up here", forState: .Normal)
            
            loginButton.titleLabel?.textColor = UIColor.whiteColor()
            loginButton.addTarget(self, action: #selector(popModal), forControlEvents: .TouchUpInside)
            loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            loginButton.tag = 1
           
            self.view.addSubview(loginButton)
        }
    }
    
    func popModal(sender: UIButton!){
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : LoginController = storyboard.instantiateViewControllerWithIdentifier("loginModalController") as! LoginController
            self.tabBarController?.presentViewControllerFromVisibleViewController(vc, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Messages"
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.clearColor()
        header.textLabel!.textColor = UIColor(hexString: "FFFFFF")
        header.textLabel?.font = UIFont(name: "American Typewriter", size: 26)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("msgCell", forIndexPath: indexPath)
        cell.textLabel!.numberOfLines = 0;
        cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        let emptyMsg: String = "No messages yet"
        
        cell.selectionStyle = .None;
        cell.accessoryType = .None;
        cell.userInteractionEnabled = false
        cell.textLabel?.text = emptyMsg
        cell.detailTextLabel?.text = ""
        cell.textLabel?.textColor = UIColor.grayColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // remove bottom extra 20px space.
        return CGFloat.min
    }
}

