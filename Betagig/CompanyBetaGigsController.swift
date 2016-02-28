//
//  CompanyBetaGigsController.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class CompanyBetaGigsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var allMyGigs: [BetaGig] = []
    var mypendingGigs: [BetaGig] = []
    var myconfirmedGigs: [BetaGig] = []
    var mypastGigs: [BetaGig] = []
    let ref = Firebase(url: "https://betagig1.firebaseio.com")
    
    @IBOutlet weak var betaGigsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print(authData)
                
                let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + authData.uid)
                
                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    
                    if let userName = snapshot.value["name"] as? String {
                        print(userName)
                        self.getGigData(userName)
                    }
                    
                })
                
            } else {
                // No user is signed in
            }
        })
    }
    
    func getGigData(userName: String){
        
        let betagigUrl = Firebase(url: "https://betagig1.firebaseio.com/betagigs")
        
        // Attach a closure to read the data
        betagigUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            for item in snapshot.children {
                let betagig = BetaGig(snapshot: item as! FDataSnapshot)
                
                if userName == betagig.company {
                    self.allMyGigs.append(betagig)
                }
            }
            
            for g in self.allMyGigs {
                if g.status == "pending" {
                    self.mypendingGigs.append(g)
                } else if g.status == "upcoming" {
                    self.myconfirmedGigs.append(g)
                } else if g.status == "completed" {
                    self.mypastGigs.append(g)
                }
            }
            
            self.betaGigsTableView.reloadData()
            
            
            }, withCancelBlock: { error in
                print(error.description)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cobetaGig", forIndexPath: indexPath)
        cell.textLabel!.numberOfLines = 0;
        cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        var item: BetaGig?
        if indexPath.section == 0 {
            item = mypendingGigs[indexPath.row]
        }
        else if indexPath.section == 1 {
            item = myconfirmedGigs[indexPath.row]
        }
        else{
            item = mypastGigs[indexPath.row]
        }
        
        cell.textLabel?.text = item?.gig
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pending BetaGigs"
        }
        else if section == 1 {
            return "Upcoming BetaGigs"
        }
        else{
            return "Past BetaGigs"
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
