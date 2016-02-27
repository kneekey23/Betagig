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
    var categories: [String] = ["Blue Collar Jobs", "White collar jobs"]
    

    override func viewDidLoad() {
        // Initialize the collection views, set the desired frames
        //grab those lists above from the database

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
       
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

