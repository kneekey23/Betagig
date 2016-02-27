//
//  CompanyProfileController.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase


class CompanyProfileController: UITableViewController {

    
    let ref = Firebase(url: "https://betagig1.firebaseio.com")
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "companyLogOut"{
            ref.unauth()
            let loginVC = segue.destinationViewController as! CompanyAuthController
            loginVC.hidesBottomBarWhenPushed = true
        }
    }
}
