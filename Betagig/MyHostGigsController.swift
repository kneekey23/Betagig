//
//  MyHostGigsController.swift
//  Betagig
//
//  Created by Melissa on 4/6/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class MyHostGigsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var myGigIds: [String] = []
    var allMyGigs: [BetaGig] = []
    var mypendingGigs: [BetaGig] = []
    var myconfirmedGigs: [BetaGig] = []
    var mypastGigs: [BetaGig] = []
    let ref = Firebase(url: "https://betagig1.firebaseio.com")
    
    @IBOutlet weak var hostGigsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ref.observeAuthEventWithBlock({ authData in
//            if authData != nil {
//                // user authenticated
//            
//                let uid: String = "db5ee49a-bb55-4f02-b58f-5fcc19bdb5c9"
//                let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + uid)
//                
//                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
//                    
//                    if let userName = snapshot.value["name"] as? String {
//                        print(userName)
//                    }
//                    
//                    if let ids = snapshot.value["betagigs"] as? [String] {
//                        self.myGigIds = ids
//                    }
//                    
//                    for gigId in self.myGigIds {
//                        print(gigId)
//                    }
//                    
//                    self.getGigData(self.myGigIds)
//                    
//                })
//                
//            } else {
//                print("not logged in")
//                // No user is signed in
//            }
//        })
        
        if loggedIn {
//            let uid = "db5ee49a-bb55-4f02-b58f-5fcc19bdb5c9"
//            let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + uid)
//            
//            userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
//                print(snapshot.value["name"])
//                if let userName = snapshot.value["name"] as? String {
//                    print(userName)
//                }
//                
//                if let ids = snapshot.value["betagigs"] as? [String] {
//                    self.myGigIds = ids
//                }
//                
//                for gigId in self.myGigIds {
//                    print(gigId)
//                }
//                
//                self.getGigData(self.myGigIds)
//                
//            })
            
            
            
//            self.myGigIds = ["4", "5"]
//            self.getGigData(self.myGigIds)
            
            self.getHardcodedGigData()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        ref.observeAuthEventWithBlock({ authData in
//            if authData != nil {
//                // user authenticated
//             
//                let uid: String = "db5ee49a-bb55-4f02-b58f-5fcc19bdb5c9"
//                let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + uid)
//                
//                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
//                    
//                    if let userName = snapshot.value["name"] as? String {
//                        print(userName)
//                    }
//                    
//                    if let ids = snapshot.value["betagigs"] as? [String] {
//                        self.myGigIds = ids
//                    }
//                    
//                    for gigId in self.myGigIds {
//                        print(gigId)
//                    }
//                    
//                    self.getGigData(self.myGigIds)
//                    
//                })
//                
//            } else {
//                // No user is signed in
//            }
//        })
        
        if loggedIn {
            let uid = "db5ee49a-bb55-4f02-b58f-5fcc19bdb5c9"
            let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + uid)
            
//            userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
//                
//                if let userName = snapshot.value["name"] as? String {
//                    print(userName)
//                }
//                
//                if let ids = snapshot.value["betagigs"] as? [String] {
//                    self.myGigIds = ids
//                }
//                
//                for gigId in self.myGigIds {
//                    print(gigId)
//                }
//                
//                self.getGigData(self.myGigIds)
//                
//            })
            
            
            
//            self.myGigIds = ["4", "5"]
//            self.getGigData(self.myGigIds)
            
            self.getHardcodedGigData()
        }
    }
    
    func getHardcodedGigData(){
        
        self.allMyGigs.removeAll()
        self.myconfirmedGigs.removeAll()
        self.mypastGigs.removeAll()
        self.mypendingGigs.removeAll()
        
        let betagig1 = BetaGig(testerid: "d7e4c5bf-7c55-4b76-b350-6385e413a220", testername: "Brad Green", testeremail: "brad.green@ucla.edu", id: "4", company: "Vandelay Industries", gig: "IT Administrator", status: "upcoming", date: "Apr 18, 2016", time: "9:00 AM - 5:00 PM", contact: "Marv Marvington", cost: 120.00, street: "6200 Wilshire Blvd", city: "Los Angeles", state: "CA", zip: "90048", lat: "34.062845", long: "-118.363667", key: "")
        
        let betagig2 = BetaGig(testerid: "d7e4c5bf-7c55-4b76-b350-6385e413a220", testername: "Nicki Klein", testeremail: "nicki@shortkey.io", id: "5", company: "Vandelay Industries", gig: "IT Administrator", status: "pending", date: "Apr 25, 2016", time: "9:00 AM - 5:00 PM", contact: "Marv Marvington", cost: 120.00, street: "6200 Wilshire Blvd", city: "Los Angeles", state: "CA", zip: "90048", lat: "34.062845", long: "-118.363667", key: "")
        
        self.allMyGigs.append(betagig1)
        self.allMyGigs.append(betagig2)
        
        
        for g in self.allMyGigs {
            if g.status == "pending" {
                self.mypendingGigs.append(g)
            } else if g.status == "upcoming" {
                self.myconfirmedGigs.append(g)
            } else if g.status == "completed" {
                self.mypastGigs.append(g)
            }
        }
        
        self.hostGigsTableView.reloadData()
        
    }
    
    func getGigData(myGigIds: [String]){
        
        let betagigUrl = Firebase(url: "https://betagig1.firebaseio.com/betagigs")
        
        // Attach a closure to read the data
        betagigUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
            self.allMyGigs.removeAll()
            self.myconfirmedGigs.removeAll()
            self.mypastGigs.removeAll()
            self.mypendingGigs.removeAll()
            for item in snapshot.children {
                let betagig = BetaGig(snapshot: item as! FDataSnapshot)
                
                for myId in myGigIds {
                    if myId == betagig.id {
                        self.allMyGigs.append(betagig)
                    }
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
            
            self.hostGigsTableView.reloadData()
            
            
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
            if mypendingGigs.count < 1{
                return 1
            }else{
                 return mypendingGigs.count
            }
           
        }
        else if section == 1{
            if myconfirmedGigs.count < 1{
                return 1
            }else{
                 return myconfirmedGigs.count
            }
           
        }
        else{
            if mypastGigs.count < 1{
                return 1
            }
            else{
                 return mypastGigs.count
            }
           
        }
     
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("betaGig", forIndexPath: indexPath)
        cell.textLabel!.numberOfLines = 0;
        cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        var item: BetaGig?
        var emptyMsg: String = "No betagigs"
        var showEmptyMsg: Bool = false
        if indexPath.section == 0 {
            if mypendingGigs.count < 1 {
                showEmptyMsg = true
                emptyMsg = "No pending betagigs"
            } else{
                 item = mypendingGigs[indexPath.row]
            }
            
        }
        else if indexPath.section == 1 {
           
            if myconfirmedGigs.count < 1 {
                showEmptyMsg = true
                emptyMsg = "No upcoming betagigs"
            } else {
                item = myconfirmedGigs[indexPath.row]
            }
        }
        else{
            if mypastGigs.count < 1 {
                showEmptyMsg = true
                emptyMsg = "No past betagigs"
            } else {
                item = mypastGigs[indexPath.row]
            }
        }

        if showEmptyMsg == false {
            cell.textLabel?.text = item?.gig
            cell.detailTextLabel?.text = (item?.company)! + ", " + (item?.date)!
            cell.selectionStyle = .Default
            cell.accessoryType = .DisclosureIndicator
            cell.userInteractionEnabled = true
            cell.textLabel?.textColor = UIColor(hexString: "B048B5")
          
        } else {
            cell.selectionStyle = .None;
            cell.accessoryType = .None;
            cell.userInteractionEnabled = false
            cell.textLabel?.text = emptyMsg
            cell.detailTextLabel?.text = ""
            cell.textLabel?.textColor = UIColor.grayColor()
        }
      

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
           return "Pending"
        }
        else if section == 1 {
            return "Upcoming"
        }
        else{
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
//        header.contentView.backgroundColor = UIColor(white: 1, alpha: 1) // alpha: 0.7
        header.contentView.backgroundColor = UIColor(hexString: "EDEDED")
        header.textLabel!.textColor = UIColor(hexString: "E65100") //make the text orange
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
//        header.alpha = 0.5 //make the header transparent
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("hostGigDetail", sender: hostGigsTableView.cellForRowAtIndexPath(indexPath))
    }
    
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // remove bottom extra 20px space.
        return CGFloat.min
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "hostGigDetail"{
            
            let companyBetaGigDetailController = segue.destinationViewController as! CompanyBetaGigDetailController
            
            if sender != nil {
                
                if (sender!.isKindOfClass(UITableViewCell)) {
                    
                    let cell = sender as! UITableViewCell
                    let nameOfGig = cell.textLabel?.text
                    var selectedBetagig: BetaGig?
                    for g in self.allMyGigs {
                        if g.gig == nameOfGig! {
                            selectedBetagig = g
                            break
                        }
                    }
                    
                    companyBetaGigDetailController.betagig = selectedBetagig
                }
                
            }
            
        }
    }

}
