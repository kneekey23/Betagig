//
//  BrowseController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//



import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class BrowseViewController: UIViewController, UITableViewDataSource, CityListViewControllerDelegate, LoginViewControllerDelegate {

    @IBOutlet weak var categoryTableView: UITableView!
    
    var tableImagesOne: [String] = ["Cook", "Fireman", "Doctor", "Nurse"]
    var tableImagesTwo: [String] = ["Barber Chair", "School Director"]
    var categories: [Category] = []
    var careers: [Career] = []
    var cityButton: UIButton?
    var city:String?
  
    let headers = [
        "x-api-key": "3euU5d6Khj5YQXZNDBrqq1NDkDytrwek1AyToIHA",
        "Content-Type": "application/json"
    ]
    
    override func viewDidLoad() {
        
        // Initialize the collection views, set the desired frames
        //grab those lists above from the database
        
        super.viewDidLoad()
        getData()
        cityButton =  UIButton(type: .Custom)
        cityButton!.frame = CGRectMake(0, 0, 100, 40) as CGRect
        cityButton!.tintColor = UIColor.blackColor()
        cityButton!.setTitle("San Francisco" + " \u{25BE}", forState: UIControlState.Normal)
        cityButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cityButton!.addTarget(self, action: #selector(BrowseViewController.clickOnButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = cityButton
        
//        ref.observeAuthEventWithBlock({ authData in
////            if authData != nil {
//            if loggedIn {
//                // user authenticated
//                print("logged in")
//            } else {
//                // No user is signed in
//                self.performSegueWithIdentifier("loginSegue", sender: self)
//            }
//        })
//        self.performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    func clickOnButton(button: UIButton) {
         self.performSegueWithIdentifier("citySegue", sender: button)
    }
    
    func sendValue(value: NSString) {
        city = value as String
        cityButton!.setTitle(city! + " \u{25BE}", forState: UIControlState.Normal)
        
    }
    
    func getData(){
        
        let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/categories";

        
        Alamofire.request(.GET, apiUrl, headers: headers).validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    let list: Array<JSON> = json["Items"].arrayValue
                    for item in list{
                        
                        
                        self.categories.append(Category(json: item)!)
                        
                    }
                    
                    
                    self.refreshCareers()
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
        }
    }
    
    func refreshCareers(){
        
        let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/career";
        
        Alamofire.request(.GET, apiUrl, headers: headers).validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    let list: Array<JSON> = json["Items"].arrayValue
                    for item in list{
                
                        self.careers.append(Career(json: item)!)
                        
                    }
                    
                    for cat in self.categories{
                        for c in self.careers{
                            if c.categoryId == cat.id{
                                cat.careers.append(c.title!)
                            }
                        }
                    }
                    
                    self.getCareerDetails()
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
        }
        
    }
    
    func getCareerDetails() {
        
            
            for cat in self.categories {
                
                for c in cat.careers {
                    
                    var companiesInCat = [Company]()
                    for career in self.careers {
                        if career.title == c {
                        
                            //Get Companies by Career Id
                            let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/company?id=\(career.id!)";
                          
                            
                            Alamofire.request(.GET, apiUrl, headers: headers).validate()
                                .responseJSON { response in
                                    
                                    switch response.result {
                                    case .Success(let data):
                                        let json = JSON(data)
                                        let list: Array<JSON> = json["Items"].arrayValue
                                        for item in list{
                                            
                                            
                                            companiesInCat.append(Company(json: item)!)
                                            
                                        }
                                        
                                    case .Failure(let error):
                                        print("Request failed with error: \(error)")
                                    }
                                    
                            }
                            
                            // Determine min and max costs for this career
                            var costs: [Int] = []
                            for c in companiesInCat {
                                costs.append(c.costPerDay!)
                            }
                            
                            costs.sortInPlace {
                                return $0 < $1
                            }
                            var min: Int = 0
                            var max: Int = 0
                            if costs.count > 0{
                                 min = costs[0]
                                 max = costs[costs.count - 1]
                            }
                          
                            let numBetagigs = companiesInCat.count
                            
                            cat.careerDetails.append(Career(title: career.title!, iconUrl: career.iconUrl!, categoryId: career.categoryId!, minCost: min, maxCost: max, numBetagigs: numBetagigs, id: career.id!))
                            
                        }
                    }
                }
            }
            
            self.categoryTableView.reloadData()
            
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return categories.count
        
    }
    
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return categories[section].name
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
        
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(hexString: "FFF"); 
        header.textLabel!.textColor = UIColor(hexString: "E65100")
       // header.alpha = 0.5 //make the header transparent
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
        
        cell.category = categories[indexPath.section]
        
        return cell
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "companySegue" {
            
            let companyController = segue.destinationViewController as! CompanyListViewController
            
            
            
            //make call to db to load list of projects and populate a project array based off what they selected
            
            //to figure out what they selected user below code with sender to grab if they selected "math" or "lawyer" and send to db to get all projects under that category or subject
            
            if sender != nil {
                
                if (sender!.isKindOfClass(CollectionViewCell)) {
                    
                    let cell = sender as! CollectionViewCell
                    print(cell.title.text!)
                    companyController.careerName = cell.title.text!
                    companyController.careerId = cell.careerId!
                    
                }
                
                
            }
            
        }
        
//        if segue.identifier == "loginSegue" {
//            let loginController = segue.destinationViewController as! LoginController
//            loginController.delegate = self
//        }
//        
        if segue.identifier == "citySegue" {
            let secondController = segue.destinationViewController as! CityListController
            secondController.delegate = self
        }

        
    }
    
    
    
    
    
}