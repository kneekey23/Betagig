//
//  MyBetaGigsController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class MyBetaGigsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var myGigIds: [String] = []
    var allMyGigs: [BetaGig] = []
    var mypendingGigs: [BetaGig] = []
    var myconfirmedGigs: [BetaGig] = []
    var mypastGigs: [BetaGig] = []
    var needsToRefresh = true
    
    @IBOutlet weak var betaGigsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if AmazonCognitoManager.sharedInstance.isLoggedIn() {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            AmazonCognitoManager.sharedInstance.resumeSession {
                (task) -> AnyObject! in
                dispatch_async(dispatch_get_main_queue()) {
                    if self.needsToRefresh {
                        self.getMyBetaGigs(AmazonCognitoManager.sharedInstance.currentUserId!)
                        self.needsToRefresh = false
                    }
        
                    
                }
                return nil
            }
        } else {

            let x: CGFloat = self.view.frame.size.width/2 - 321/2
            let y: CGFloat = self.view.frame.size.height/2 - 49/2
            let loginButton: UIButton = UIButton(frame: CGRect(x: x, y: y, width: 321, height: 49))
            
            loginButton.backgroundColor = UIColor(hexString: "E65100")
            loginButton.setTitle("Login or Sign up here", forState: .Normal)
            
            loginButton.titleLabel?.textColor = UIColor.whiteColor()
            loginButton.addTarget(self, action: #selector(popModal), forControlEvents: .TouchUpInside)
            loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            loginButton.tag = 1
            self.betaGigsTableView.hidden = true
            self.view.addSubview(loginButton)
         
      
        }

    }
    
    func popModal(sender: UIButton!){
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : LoginController = storyboard.instantiateViewControllerWithIdentifier("loginModalController") as! LoginController
            self.tabBarController?.presentViewControllerFromVisibleViewController(vc, animated: true)
        }
    }


    func getMyBetaGigs(userId: String){
        
        self.allMyGigs.removeAll()
        self.mypendingGigs.removeAll()
        self.myconfirmedGigs.removeAll()
        self.mypastGigs.removeAll()

        let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/betagig/user?id=\(userId)";

        
        Alamofire.request(.GET, apiUrl, headers: Constants.headers).validate()
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
                        
                        self.betaGigsTableView.reloadData()
                    
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
        header.contentView.backgroundColor = UIColor(white: 1, alpha: 0.7)
//        header.contentView.backgroundColor = UIColor.clearColor()
        header.textLabel!.textColor = UIColor(hexString: "E65100") //make the text orange
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("betaGigDetail", sender: betaGigsTableView.cellForRowAtIndexPath(indexPath))
    }
    
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // remove bottom extra 20px space.
        return CGFloat.min
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "betaGigDetail"{
            
            let betagigDetailController = segue.destinationViewController as! BetaGigDetailController
            
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
