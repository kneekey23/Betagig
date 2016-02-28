//
//  CompanyBetaGigsController.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class CompanyBetaGigsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var mypendingGigs: [String] = []
    var myconfirmedGigs: [String] = []
    var mypastGigs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        header.contentView.backgroundColor = UIColor(hexString: "3D3C3A") //make the background color light blue
        header.textLabel!.textColor = UIColor(hexString: "4EE2EC") //make the text white
        header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 16)!
        //header.alpha = 0.5 //make the header transparent
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // remove bottom extra 20px space.
        return CGFloat.min
    }
    
}
