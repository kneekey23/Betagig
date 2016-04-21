//
//  CompanyProfileController.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit



class CompanyProfileController: UITableViewController {

    
  
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "companyLogOut"{
          
            let loginVC = segue.destinationViewController as! CompanyAuthController
            loginVC.hidesBottomBarWhenPushed = true
        }
    }
}
