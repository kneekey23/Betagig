//
//  CityListController.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class CityListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cities: [String] = ["Los Angeles", "San Francisco", "New York", "Chicago", "Miami", "Dallas", "New Orleans", "San Diego", "Atlanta", "Las Vegas", "Austin"]
    
    var delegate:CityListViewControllerDelegate!
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var cityListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
             cityListTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      //return city to other view and close modal
        delegate?.sendValue(self.cities[indexPath.row])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = cities[indexPath.row]
        
        return cell
    }
    


}

protocol CityListViewControllerDelegate
{
    func sendValue(var value : NSString)
}

