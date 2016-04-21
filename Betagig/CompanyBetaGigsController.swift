//
//  CompanyBetaGigsController.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class CompanyBetaGigsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var allMyGigs: [BetaGig] = []
    var mypendingGigs: [BetaGig] = []
    var myconfirmedGigs: [BetaGig] = []
    var mypastGigs: [BetaGig] = []
    //let ref = Firebase(url: "https://betagig1.firebaseio.com")
    
    @IBOutlet weak var betaGigsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ref.observeAuthEventWithBlock({ authData in
//            if authData != nil {
//                // user authenticated
//                print(authData)
//                
//                let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + authData.uid)
//                
//                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
//                    
//                    if let userName = snapshot.value["name"] as? String {
//                        print(userName)
//                        self.getGigData(userName)
//                    }
//                    
//                })
//                
//            } else {
//                // No user is signed in
//            }
//        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        ref.observeAuthEventWithBlock({ authData in
//            if authData != nil {
//                // user authenticated
//                print(authData)
//                
////                let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + authData.uid)
////                
////                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
////                    
////                    if let userName = snapshot.value["name"] as? String {
////                        print(userName)
////                        self.getGigData(userName)
////                    }
////                    
////                })
//                let userName = "larry@belkin.com"
//                self.getGigData(userName)
//                
//            } else {
//                // No user is signed in
//            }
//        })
    }
    
    func getGigData(userName: String){
        
//        let betagigUrl = Firebase(url: "https://betagig1.firebaseio.com/betagigs")
//        self.allMyGigs.removeAll()
//        self.mypendingGigs.removeAll()
//        self.myconfirmedGigs.removeAll()
//        self.mypastGigs.removeAll()
//        
//        // Attach a closure to read the data
//        betagigUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
//            
//            for item in snapshot.children {
//                let betagig = BetaGig(snapshot: item as! FDataSnapshot)
//                
//                if userName == betagig.company {
//                    self.allMyGigs.append(betagig)
//                }
//            }
//            
//            for g in self.allMyGigs {
//                if g.status == "pending" {
//                    self.mypendingGigs.append(g)
//                } else if g.status == "upcoming" {
//                    self.myconfirmedGigs.append(g)
//                } else if g.status == "completed" {
//                    self.mypastGigs.append(g)
//                }
//            }
//            
//            self.betaGigsTableView.reloadData()
//            
//            
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return directionsGrouped[section].count - 1
        if section == 0{
            if mypendingGigs.count < 1 {
                return 1
            } else {
                return mypendingGigs.count
            }
        }
        else if section == 1{
            if myconfirmedGigs.count < 1 {
                return 1
            } else {
                return myconfirmedGigs.count
            }
        }
        else{
            if mypastGigs.count < 1 {
                return 1
            } else {
                return mypastGigs.count
            }
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cobetaGig", forIndexPath: indexPath)
        cell.textLabel!.numberOfLines = 0;
        cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        var item: BetaGig?
        var emptyMsg: String = "No betagigs"
        var showEmptyMsg: Bool = false
        if indexPath.section == 0 {
            if mypendingGigs.count < 1 {
                showEmptyMsg = true
                emptyMsg = "No pending betagigs"
            } else {
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
            cell.textLabel?.text = item?.careerName
            cell.selectionStyle = .Default
            cell.accessoryType = .DisclosureIndicator
            cell.userInteractionEnabled = true
            cell.textLabel?.textColor = UIColor(hexString: "B048B5")
        } else {
            cell.selectionStyle = .None;
            cell.accessoryType = .None;
            cell.userInteractionEnabled = false
            cell.textLabel?.text = emptyMsg
            cell.textLabel?.textColor = UIColor.grayColor()
        }
        
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("coBetaGigDetail", sender: betaGigsTableView.cellForRowAtIndexPath(indexPath))
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(hexString: "3D3C3A") //make the background color light blue
        header.textLabel!.textColor = UIColor(hexString: "4EE2EC") //make the text white
        header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 16)!
        //header.alpha = 0.5 //make the header transparent
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // remove bottom extra 20px space.
        return CGFloat.min
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "coBetaGigDetail"{
            
            let betagigDetailController = segue.destinationViewController as! CompanyBetaGigDetailController
            
            if sender != nil {
                
                if (sender!.isKindOfClass(UITableViewCell)) {
                    
                    let cell = sender as! UITableViewCell
                    let nameOfGig = cell.textLabel?.text
                    var selectedBetagig: BetaGig?
                    for g in self.allMyGigs {
                        if g.careerName == nameOfGig! {
                            selectedBetagig = g
                            break
                        }
                    }
                    
                    betagigDetailController.betagig = selectedBetagig
                }
                
            }
            
        }
    }
    
}
