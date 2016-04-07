//
//  MessagesController.swift
//  Betagig
//
//  Created by Melissa Hargis on 4/6/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit

class MessagesController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var closeBtn: UIButton!

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.backgroundView = UIImageView(image: UIImage(named: "vintage-typewriter"))
        mainTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Messages"
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(hexString: "FFFFFF")
        header.textLabel!.textColor = UIColor(hexString: "E65100") //make the text orange
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
        //        header.alpha = 0.5 //make the header transparent
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("msgCell", forIndexPath: indexPath)
        cell.textLabel!.numberOfLines = 0;
        cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        let emptyMsg: String = "No messages yet"
        
        cell.selectionStyle = .None;
        cell.accessoryType = .None;
        cell.userInteractionEnabled = false
        cell.textLabel?.text = emptyMsg
        cell.detailTextLabel?.text = ""
        cell.textLabel?.textColor = UIColor.grayColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // remove bottom extra 20px space.
        return CGFloat.min
    }
}

