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


class BrowseViewController: UIViewController, UITableViewDataSource, CityListViewControllerDelegate {

    @IBOutlet weak var categoryTableView: UITableView!
    
    var tableImagesOne: [String] = ["Cook", "Fireman", "Doctor", "Nurse"]
    var tableImagesTwo: [String] = ["Barber Chair", "School Director"]
    var categories: [Category] = []
    var careers: [Career] = []
    var cityButton: UIButton?
    
    
    override func viewDidLoad() {
        
        // Initialize the collection views, set the desired frames
        //grab those lists above from the database
        
        super.viewDidLoad()
        getData()
        cityButton =  UIButton(type: .Custom)
        cityButton!.frame = CGRectMake(0, 0, 100, 40) as CGRect
        cityButton!.tintColor = UIColor.blackColor()
        cityButton!.setTitle("Los Angeles" + " \u{25BE}", forState: UIControlState.Normal)
        cityButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cityButton!.addTarget(self, action: Selector("clickOnButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = cityButton
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
            
            for cat in self.categories {
                for c in cat.careers {
                    for career in self.careers {
                        if career.title == c {
                            // add career.icon to the category object
                            cat.careerDetails.append(Career(title: career.title, icon: career.icon, category: career.category))
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
        header.contentView.backgroundColor = UIColor(hexString: "3D3C3A"); //make the background color light blue
        header.textLabel!.textColor = UIColor(hexString: "B048B5") //make the text white
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
        
        if segue.identifier == "citySegue" {
            let secondController = segue.destinationViewController as! CityListController
            secondController.delegate = self
        }

        
    }
    
    
    
    
    
}