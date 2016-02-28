//
//  CompanyBetaGigDetailController.swift
//  Betagig
//
//  Created by Nicki on 2/28/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class CompanyBetaGigDetailController: UIViewController {
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var gigRequested: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBAction func showActionSheet(sender: AnyObject) {
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Actions to Take", message: "", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        
        let lyftActionButton: UIAlertAction = UIAlertAction(title: "Accept Betagig Request", style: .Default)
            { action -> Void in
                //change status in database here and update label on page.  NJK
        }
        actionSheetControllerIOS8.addAction(lyftActionButton)
        
        let tweetActionButton: UIAlertAction = UIAlertAction(title: "Decline Betagig Request", style: .Cancel)
            { action -> Void in
            //change status in database here and update label on page.  NJK
        }
        actionSheetControllerIOS8.addAction(tweetActionButton)
        
        let fbActionButton: UIAlertAction = UIAlertAction(title: "Email Betagig Requester", style: .Default){
            action -> Void in
            //open mail app with user email populated. NJK
        }
        actionSheetControllerIOS8.addAction(fbActionButton)
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
