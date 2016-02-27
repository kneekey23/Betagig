//
//  CompanyListViewController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class CompanyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var companies: [String] = []
    var career: String = ""
    override func viewDidLoad() {
        // Initialize the collection views, set the desired frames
        //grab those lists above from the database
        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LearnCell", forIndexPath: indexPath)
        
        // Configure the cell...
       
            let item = self.companies[indexPath.row]
            cell.textLabel?.text = item
        
        
        return cell
        
    }
}
