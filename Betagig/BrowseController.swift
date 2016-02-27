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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
       
        return cell
    }
 
    
}

