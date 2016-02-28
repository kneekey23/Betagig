//
//  BetaGigSuccessController.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class BetaGigSuccessController: UIViewController {
    var delegate:BetaGigRequestDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func closeModal(sender: AnyObject) {
         delegate?.goBackToRoot()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func browseReturn(sender: AnyObject) {
        delegate?.goBackToRoot()
        self.dismissViewControllerAnimated(true, completion: nil)
      
    }

    @IBAction func betaGigAction(sender: AnyObject){
        delegate?.goBackToMyBetaGigs()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

protocol BetaGigRequestDelegate
{
    func goBackToRoot()
    func goBackToMyBetaGigs()
}


