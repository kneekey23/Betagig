//
//  CompanyBetaGigDetailController.swift
//  Betagig
//
//  Created by Nicki on 2/28/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CompanyBetaGigDetailController: UIViewController {
    
    var betagig: BetaGig?
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var gigName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var gigRequested: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var company: UILabel!
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
        company.text = betagig!.companyName!
        nameButton.setTitle(betagig!.testerName, forState: UIControlState.Normal)
         nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        date.text = betagig!.startDate! + " - " + betagig!.endDate!
        time.text = betagig!.time!

        cost.text = "$" + betagig!.costPerDay! + "/per day"

    }
    
    func updateGigStatus(newStatus: String) {
        
        let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/betagig/status";
        let headers = [
            "x-api-key": "3euU5d6Khj5YQXZNDBrqq1NDkDytrwek1AyToIHA",
            "Content-Type": "application/json"
        ]
        let body = ["id": String(self.betagig!.id!), "status": newStatus]
        Alamofire.request(.POST, apiUrl, parameters: body, headers: headers, encoding: .JSON).validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
               print("success")
                    
                case .Failure:
                 print("failure")
                }
                
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "userProfileSegue"{
            let userProfileController = segue.destinationViewController as! CompanyUserProfileController
            userProfileController.userName = self.betagig!.testerName
            
        }
    }

}
