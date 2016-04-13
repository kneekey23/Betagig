//
//  BetaGigDetailController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Social
import MapKit
import Alamofire
import SwiftyJSON

class BetaGigDetailController: UIViewController {
    
    var betagig: BetaGig?
    
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var gigName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var city: UILabel!
     let userId: String = "a2c1144f-6842-4249-b3cd-77bd8571cf04"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let companyPin = MapAnnotation(title: betagig!.companyName!, coordinate: CLLocationCoordinate2D(latitude: Double(betagig!.lat!), longitude: Double(betagig!.long!)), info: betagig!.companyStreet!)
        mapview.addAnnotation(companyPin)
        let span = MKCoordinateSpanMake(0.075, 0.075)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(betagig!.lat!), longitude: Double(betagig!.long!)), span: span)
        mapview.setRegion(region, animated: true)
        setFields()
    }
    
    func setFields() {
        gigName.text = betagig!.careerName
        status.text = betagig!.status
        company.text = betagig!.companyName
        date.text = betagig!.startDate! + " - " + betagig!.endDate!
        time.text = betagig!.time
        cost.text = "$" + betagig!.costPerDay! + "/per day"
        contact.text = betagig!.companyContactUserName
        street.text = betagig!.companyStreet
        city.text = betagig!.companyCity! + ", " + betagig!.companyState! + " " + String(betagig!.companyZip!)
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
                     let lyftAppurl = NSURL(string: "lyft://ridetype?id=lyft&partner=SuyEX9chJQys&destination[latitude]=" + String(self.betagig!.lat) + "&destination[longitude]=" + String(self.betagig!.long))!
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
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Cancel this Betagig request", style: .Default){
            action -> Void in
            
            let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/betagig";
            let headers = [
                "x-api-key": "3euU5d6Khj5YQXZNDBrqq1NDkDytrwek1AyToIHA",
                "Content-Type": "application/json"
            ]
            let body = ["id": String(self.betagig!.id!)]
            Alamofire.request(.DELETE, apiUrl, parameters: body, headers: headers, encoding: .JSON).validate()
                .responseJSON { response in
                    
                    switch response.result {
                    case .Success:
                        //pop a success modal and reload tableview MKH
                        let msg = "You have successfully cancelled this pending betagig request!"
                        let alertController = UIAlertController(title: "Betagig Deleted", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
                            self.navigationController?.popToRootViewControllerAnimated(true)
                        })
                        alertController.addAction(okAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        
                    case .Failure:
                        //pop a success modal and reload tableview MKH
                        let msg = "There was an error cancelling this pending betagig request. Please try again."
                        let alertController = UIAlertController(title: "Betagig Not Deleted", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
                            self.navigationController?.popToRootViewControllerAnimated(true)
                        })
                        alertController.addAction(okAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }

                    
            }
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        let subview = actionSheetControllerIOS8.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(hexString: "B048B5")
        alertContentView.layer.cornerRadius = 0;
        actionSheetControllerIOS8.view.tintColor = UIColor(hexString: "4EE2EC")
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
 
    }
}
