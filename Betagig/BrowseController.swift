//
//  BrowseController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//



import Foundation
import UIKit
import Firebase


class BrowseViewController: UIViewController, UITableViewDataSource, CityListViewControllerDelegate, LoginViewControllerDelegate {

    @IBOutlet weak var categoryTableView: UITableView!
    
    var tableImagesOne: [String] = ["Cook", "Fireman", "Doctor", "Nurse"]
    var tableImagesTwo: [String] = ["Barber Chair", "School Director"]
    var categories: [Category] = []
    var careers: [Career] = []
    var cityButton: UIButton?
    let ref = Firebase(url: "https://betagig1.firebaseio.com")
    
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
        cityButton!.addTarget(self, action: Selector("clickOnButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = cityButton
        
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print("logged in")
            } else {
                // No user is signed in
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
        })
//        self.performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    func clickOnButton(button: UIButton) {
         self.performSegueWithIdentifier("citySegue", sender: button)
    }
    
    func sendValue(value: NSString) {
        let city = value as String
        cityButton!.setTitle(city + " \u{25BE}", forState: UIControlState.Normal)
        
    }
    
    func getData(){
        
        let ref = Firebase(url: "https://betagig1.firebaseio.com/categories")
        
        // Attach a closure to read the data
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var categories = [Category]()
            
            for item in snapshot.children {
                let category = Category(snapshot: item as! FDataSnapshot)
                categories.append(category)
            }
            
            for c in categories {
                print(c.name)
            }
            
            self.categories = categories
            
            self.refreshCareers()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
    func refreshCareers(){
        
        let ref = Firebase(url: "https://betagig1.firebaseio.com/careers")
        
        // Attach a closure to read the data
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var careers = [Career]()
 
            for item in snapshot.children {
                let career = Career(snapshot: item as! FDataSnapshot)
                careers.append(career)
            }
            
            self.careers = careers
            
            self.getCareerDetails()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
    func getCareerDetails() {
        
        let refCompanies = Firebase(url: "https://betagig1.firebaseio.com/companies")
        refCompanies.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var companies = [Company]()
            
            for item in snapshot.children {
                let company = Company(snapshot: item as! FDataSnapshot)
                companies.append(company)
            }
            
            for cat in self.categories {
                
                for c in cat.careers {
                    
                    var companiesInCat = [Company]()
                    for career in self.careers {
                        if career.title == c {
                            
                            
                            // Get all companies for that career
                            for c in companies {
                                for gig in c.gigs {
                                    if gig == career.title {
                                        companiesInCat.append(c)
                                    }
                                }
                            }
                            
                            // Determine min and max costs for this career
                            var costs: [Int] = []
                            for c in companiesInCat {
                                costs.append(c.cost)
                            }
                            
                            costs.sortInPlace {
                                return $0 < $1
                            }
                            
                            let min = costs[0]
                            let max = costs[costs.count - 1]
                            let numBetagigs = companiesInCat.count
                            
                            cat.careerDetails.append(Career(title: career.title, icon: career.icon, category: career.category, minCost: min, maxCost: max, numBetagigs: numBetagigs))
                            
                        }
                    }
                }
            }
            
            self.categoryTableView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
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
                    companyController.career = cell.title.text!
                    
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