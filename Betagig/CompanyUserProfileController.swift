//
//  CompanyUserProfileController.swift
//  Betagig
//
//  Created by Nicki on 3/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class CompanyUserProfileController: UIViewController {


    @IBAction func userProfile(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var userNameLabel: UILabel!
    var userName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = userName!
    }
}
