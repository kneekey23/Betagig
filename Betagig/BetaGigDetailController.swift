//
//  BetaGigDetailController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Social

class BetaGigDetailController: UIViewController {
    
    var betagig: BetaGig?
    
    @IBOutlet weak var gigName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var city: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(betagig!.gig)
        setFields()
    }
    
    func setFields() {
        gigName.text = betagig!.gig
        status.text = betagig!.status
        company.text = betagig!.company
        date.text = betagig!.date
        time.text = betagig!.time
        cost.text = "$" + String(Int(betagig!.cost)) + "/per day"
        contact.text = betagig!.contact
        street.text = betagig!.street
        city.text = betagig!.city + ", " + betagig!.state + " " + betagig!.zip
    }

    @IBAction func showActionSheet(sender: AnyObject) {
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Actions to Take", message: "", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        
        let lyftActionButton: UIAlertAction = UIAlertAction(title: "Take a Lyft", style: .Default)
            { action -> Void in
                // If Lyft is not installed, send the user to the Apple App Store
                let myApp = UIApplication.sharedApplication()
                let lyftAppURL = NSURL(string: "lyft://partner=SuyEX9chJQys")!
                if myApp.canOpenURL(lyftAppURL) {
                    // Lyft is installed; launch it
                     let lyftAppurl = NSURL(string: "lyft://ridetype?id=lyft&partner=SuyEX9chJQys&destination[latitude]=" + self.betagig!.lat + "&destination[longitude]=" + self.betagig!.long)!
                    myApp.openURL(lyftAppurl)
                } else {
                    // Lyft not installed; open App Store
                    let lyftAppStoreURL = NSURL(string: "https://itunes.apple.com/us/app/lyft-taxi-bus-app-alternative/id529379082")!
                    myApp.openURL(lyftAppStoreURL)
                }
        }
        actionSheetControllerIOS8.addAction(lyftActionButton)
        
        let tweetActionButton: UIAlertAction = UIAlertAction(title: "Tweet About Your Betagig", style: .Default)
            { action -> Void in
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                    
                    let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    tweetShare.setInitialText("#betagig")
                    
                    self.presentViewController(tweetShare, animated: true, completion: nil)
                    
                } else {
                    
                    let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
        }
        actionSheetControllerIOS8.addAction(tweetActionButton)
        
        let fbActionButton: UIAlertAction = UIAlertAction(title: "Facebook share Your Betagig", style: .Default){
            action -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                self.presentViewController(fbShare, animated: true, completion: nil)
                
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        actionSheetControllerIOS8.addAction(fbActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Delete this Betagig request", style: .Default){
            action -> Void in
          //add code to delete beta gig request. NJK
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
    }
}
