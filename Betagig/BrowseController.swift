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


class BrowseViewController: UIViewController, UITableViewDataSource {
    
    var tableImagesOne: [String] = ["Cook", "Fireman", "Doctor", "Nurse"]
    var tableImagesTwo: [String] = ["Barber Chair", "School Director"]
    var categories: [Category] = []
    var careers: [Career] = []
    
    
    override func viewDidLoad() {
        
        // Initialize the collection views, set the desired frames
        //grab those lists above from the database
        
        super.viewDidLoad()
        refreshCategories()
        refreshCareers()
    }
    
    func refreshCategories(){
        
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
            
            for c in careers {
                print(c.title)
                print(c.icon)
                print(c.category)
            }
            
            self.careers = careers
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return categories.count
        
    }
    
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> Category? {
        
        return categories[section]
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
        
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
        
        cell.category = categories[indexPath.section].name
        
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
                    
                    companyController.career = cell.title.text!
                    
                }
                
                
            }
            
        }
        
    }
    
    
    
    
    
}