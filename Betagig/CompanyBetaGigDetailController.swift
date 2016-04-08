//
//  CompanyBetaGigDetailController.swift
//  Betagig
//
//  Created by Nicki on 2/28/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class CompanyBetaGigDetailController: UIViewController {
    
    var betagig: BetaGig?
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var gigName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var gigRequested: UILabel!
    @IBOutlet weak var date: UILabel!
  
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var nameButton: UIButton!
    
    @IBAction func showActionSheet(sender: AnyObject) {
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Actions to Take", message: "", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        
        let acceptActionButton: UIAlertAction = UIAlertAction(title: "Accept Betagig Request", style: .Default)
            { action -> Void in
                //change status in database here and update label on page.  NJK
                self.status.text = "upcoming"
                self.updateGigStatus("upcoming")
                
                //pop a success modal and reload tableview MKH
                let msg = "You have successfully accepted this pending betagig request!"
                let alertController = UIAlertController(title: "Thank You", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
                    self.navigationController?.popToRootViewControllerAnimated(true)
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
        }
        actionSheetControllerIOS8.addAction(acceptActionButton)
        
        let declineActionButton: UIAlertAction = UIAlertAction(title: "Decline Betagig Request", style: .Default)
            { action -> Void in
            //change status in database here and update label on page.  NJK
                self.status.text = "rejected"
                self.updateGigStatus("rejected")
                
                //pop a success modal and reload tableview MKH
                let msg = "You have successfully rejected this pending betagig request!"
                let alertController = UIAlertController(title: "Thank You", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
                    self.navigationController?.popToRootViewControllerAnimated(true)
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
        }
        actionSheetControllerIOS8.addAction(declineActionButton)
        
        let emailActionButton: UIAlertAction = UIAlertAction(title: "Email Betagig Requester", style: .Default){
            action -> Void in
            
            let url = NSURL(string: "mailto:\(self.betagig!.testerEmail)")!
            UIApplication.sharedApplication().openURL(url)
        }
        actionSheetControllerIOS8.addAction(emailActionButton)
        let subview = actionSheetControllerIOS8.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(hexString: "B048B5")
        alertContentView.layer.cornerRadius = 0;
        actionSheetControllerIOS8.view.tintColor = UIColor(hexString: "4EE2EC")
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(betagig!.careerName)
        setFields()
    }
    
    func setFields() {
        gigName.text = betagig!.careerName
        location.text = betagig!.companyStreet
        status.text = betagig!.status
     
        nameButton.setTitle(betagig!.testerName, forState: UIControlState.Normal)
         nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
//        date.text = betagig!.date
        time.text = betagig!.time
        cost.text = "$" + String(Int(betagig!.costPerDay!)) + "/per day"
        email.text = betagig!.testerEmail
    }
    
    func updateGigStatus(newStatus: String) {
        let id = String(betagig!.id)
        let ref = Firebase(url: "https://betagig1.firebaseio.com/betagigs")
        
        //add beta gigs to beta gig table.
        let updatedStatus = ["status": newStatus]
        ref.childByAppendingPath(id).updateChildValues(updatedStatus)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "userProfileSegue"{
            let userProfileController = segue.destinationViewController as! CompanyUserProfileController
            userProfileController.userName = self.betagig!.testerName
            
        }
    }

}
