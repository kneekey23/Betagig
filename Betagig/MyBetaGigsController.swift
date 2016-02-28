//
//  MyBetaGigsController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class MyBetaGigsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var mypendingGigs: [String] = []
    var myconfirmedGigs: [String] = []
    var mypastGigs: [String] = []
    let ref = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print(authData)
                
                let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + authData.uid)
                
                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    
//                    var allMyGigs = [Betagig]()
                    
                   
                    
                })
                
            } else {
                // No user is signed in
            }
        })
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return directionsGrouped[section].count - 1
        if section == 0{
            return mypendingGigs.count
        }
        else if section == 1{
            return myconfirmedGigs.count
        }
        else{
            return mypastGigs.count
        }
     
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("betaGig", forIndexPath: indexPath)
        cell.textLabel!.numberOfLines = 0;
        cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        var item: String = ""
        if indexPath.section == 0 {
             item = mypendingGigs[indexPath.row]
        }
        else if indexPath.section == 1 {
             item = myconfirmedGigs[indexPath.row]
        }
        else{
             item = mypastGigs[indexPath.row]
        }

        cell.textLabel?.text = item
      

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
           return "My Pending BetaGigs"
        }
        else if section == 1 {
            return "My Upcoming BetaGigs"
        }
        else{
            return "My Past BetaGigs"
        }
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(hexString: "B048B5") //make the background color light blue
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 13)!
        //header.alpha = 0.5 //make the header transparent
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // remove bottom extra 20px space.
        return CGFloat.min
    }

}
