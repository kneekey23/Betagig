//
//  BetaGigSuccessController.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class BetaGigSuccessController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func closeModal(sender: AnyObject) {
       // self.dismissViewControllerAnimated(true, completion: {})
//        let a = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainViewController") as!MainViewController
//       
//        let b = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("BrowseViewController") as! BrowseViewController
//         let nav = UINavigationController(rootViewController: b)
        // b parameters here
        // b.parameter1 = variable
        //a.pushViewController(b, animated:false)
   //     self.presentViewController(b, animated:true, completion:nil)
    }

    @IBAction func browseReturn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
         self.tabBarController?.selectedIndex = 0
            
            
            let firstNavController: UINavigationController = self.tabBarController?.selectedViewController as! UINavigationController;
            firstNavController.popToRootViewControllerAnimated(true)
        })
      
    }

    @IBAction func betaGigAction(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: {
             self.presentingViewController?.tabBarController?.selectedIndex = 1
        })
        
    }
}
