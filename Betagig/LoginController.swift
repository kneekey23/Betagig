//
//  LoginController.swift
//  Betagig
//
//  Created by Melissa Hargis on 3/29/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var closeBtn: UIButton!

    var delegate:LoginViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeBtn!.addTarget(self, action: Selector("tapOnX:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func tapOnX(button: UIButton) {
//        self.performSegueWithIdentifier("citySegue", sender: button)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

protocol LoginViewControllerDelegate
{
    func sendValue(var value : NSString)
}
