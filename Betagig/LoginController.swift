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
        
        closeBtn!.addTarget(self, action: #selector(LoginController.tapOnX(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func tapOnX(button: UIButton) {
        delegate?.setModalBoolean(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

protocol LoginViewControllerDelegate
{
    func setModalBoolean(value : Bool)
}
