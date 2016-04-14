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
import Alamofire
import SwiftyJSON

class MyHostGigsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var myGigIds: [String] = []
    var allMyGigs: [BetaGig] = []
    var mypendingGigs: [BetaGig] = []
    var myconfirmedGigs: [BetaGig] = []
    var mypastGigs: [BetaGig] = []
    
    let hostUserId: String = "1234"

    var selectedCellRow: Int = 0
    var selectedCellSection: Int = 0

    
    @IBOutlet weak var hostGigsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyHostGigs(hostUserId)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        getMyHostGigs(hostUserId)
        
        }

    
    func getMyHostGigs(hostUserId: String){
        self.allMyGigs.removeAll()
        self.mypendingGigs.removeAll()
        self.myconfirmedGigs.removeAll()
        self.mypastGigs.removeAll()
        
        let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/betagig/host?id=\(hostUserId)";
        let headers = [
            "x-api-key": "3euU5d6Khj5YQXZNDBrqq1NDkDytrwek1AyToIHA",
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(.GET, apiUrl, headers: headers).validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    let list: Array<JSON> = json["Items"].arrayValue
                    for item in list{
                        
                        
                        self.allMyGigs.append(BetaGig(json: item)!)
                        
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
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }

        
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
                print("upcoming row " + String(indexPath.row))
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
            cell.detailTextLabel?.text = (item?.companyName)! + ", " + (item?.time)!
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
        selectedCellRow = indexPath.row
        selectedCellSection = indexPath.section
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
                    
                    var selectedBetagig: BetaGig?

//                    for g in self.allMyGigs {
//                        if g.careerName == nameOfGig! {
//                            selectedBetagig = g
//                            break
//                        }

                    
                    if selectedCellSection == 0  && mypendingGigs.count > 0 {
                        selectedBetagig = mypendingGigs[selectedCellRow]
                    } else if selectedCellSection == 1 && myconfirmedGigs.count > 0 {
                        selectedBetagig = myconfirmedGigs[selectedCellRow]
                    } else if selectedCellSection == 3 && mypastGigs.count > 0 {
                        selectedBetagig = mypastGigs[selectedCellRow]
                    }
                    
//                    let cell = sender as! UITableViewCell
//                    let nameOfGig = cell.textLabel?.text
//                    var selectedBetagig: BetaGig?
//                    for g in self.allMyGigs {
//                        if g.gig == nameOfGig! {
//                            selectedBetagig = g
//                            break
//                        }
//                    }
                    
                    companyBetaGigDetailController.betagig = selectedBetagig
                }
                
            }
            
        }
    }

}
