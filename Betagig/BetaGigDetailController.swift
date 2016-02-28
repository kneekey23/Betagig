//
//  BetaGigDetailController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import UberRides

class BetaGigDetailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let button = RequestButton()
//         button.frame = CGRectMake(20, 450, 50, 335)
//        button.translatesAutoresizingMaskIntoConstraints = true
//        button.setDropoffLocation(latitude: 37.791, longitude: -122.405, nickname: "Pier 39")
      //  view.addSubview(button)
        
    }

    @IBAction func showActionSheet(sender: AnyObject) {
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Actions to Take", message: "", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
//        let uberActionButton: UIAlertAction = UIAlertAction(title: "Take an Uber", style: .Default)
//            { action -> Void in
//                print("Uber")
//        }
//        actionSheetControllerIOS8.addAction(uberActionButton)
        
        let lyftActionButton: UIAlertAction = UIAlertAction(title: "Take a Lyft", style: .Default)
            { action -> Void in
                // If Lyft is not installed, send the user to the Apple App Store
                let myApp = UIApplication.sharedApplication()
                let lyftAppURL = NSURL(string: "lyft://partner=SuyEX9chJQys")!
                if myApp.canOpenURL(lyftAppURL) {
                    // Lyft is installed; launch it
                     let lyftAppurl = NSURL(string: "lyft://ridetype?id=lyft&partner=SuyEX9chJQys&destination[latitude]=37.7763592&destination[longitude]=-122.4242038")!
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
                print("Lyft")
        }
        actionSheetControllerIOS8.addAction(tweetActionButton)
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
    }
}
