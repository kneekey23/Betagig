//
//  ProfileController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase


class ProfileController: UITableViewController {
   let ref = Firebase(url: "https://betagig1.firebaseio.com")

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "logOut"{
            ref.unauth()
            let loginVC = segue.destinationViewController as! AuthenticationController
            loginVC.hidesBottomBarWhenPushed = true
        }
    }

}
