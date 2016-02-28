//
//  CompanyListViewController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class CompanyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var companies: [Company] = []
    var career: String?
   
    @IBOutlet weak var companyListTableView: UITableView!
    override func viewDidLoad() {
        // Initialize the collection views, set the desired frames
        //grab those lists above from the database
        
        companyListTableView.tableFooterView = UIView(frame: CGRectZero)
       // self.navigationController?.navigationBar = career!
        self.title = career!
        getData()
    }

    func getData(){
        
        let ref = Firebase(url: "https://betagig1.firebaseio.com/companies")
        
        // Attach a closure to read the data
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var companies = [Company]()
            
            for item in snapshot.children {
                let company = Company(snapshot: item as! FDataSnapshot)
                companies.append(company)
            }
            
            for c in companies {
                for gig in c.gigs {
                    if gig == self.career {
                        self.companies.append(c)
                    }
                }
            }
            
            self.companyListTableView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cocell", forIndexPath: indexPath)

        // Configure the cell...
       
        let item = self.companies[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
        
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("companyDetailSegue", sender: companyListTableView.cellForRowAtIndexPath(indexPath))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "companyDetailSegue" {
            
            let companyDetailController = segue.destinationViewController as! CompanyDetailController
            
            
            
            //make call to db to load list of projects and populate a project array based off what they selected
            
            //to figure out what they selected user below code with sender to grab if they selected "math" or "lawyer" and send to db to get all projects under that category or subject
            
            if sender != nil {
                
                if (sender!.isKindOfClass(UITableViewCell)) {
                    
                    let cell = sender as! UITableViewCell
                    let nameOfCo = cell.textLabel?.text
                    var selectedCompany: Company?
                    for co in self.companies {
                        if co.name == nameOfCo! {
                            selectedCompany = co
                        }
                    }
                    
                    companyDetailController.company = selectedCompany
                }
                
            }
            companyDetailController.career = career
            
        }
        
        
    }
}
