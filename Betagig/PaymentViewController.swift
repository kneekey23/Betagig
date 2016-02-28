//
//  PaymentViewController.swift
//  Betagig
//
//  Created by Nicki on 2/28/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class PaymentViewController: UITableViewController {

let dbRef = Firebase(url: "https://betagig1.firebaseio.com")
    @IBOutlet weak var nameOnCArd: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expirationDate: UITextField!
    @IBOutlet weak var securityCode: UITextField!
    @IBAction func saveCreditCardInfo(sender: AnyObject) {
        self.dbRef.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print(authData)
                
            let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + authData.uid)
            let creditCardInfo = ["nameOnCard": self.nameOnCArd.text!, "cardNumber": self.cardNumber.text!, "expirationDate": self.expirationDate.text!, "securityCode": self.securityCode.text!]
                
             userUrl.childByAppendingPath("creditCard").setValue(creditCardInfo)
                
               let alertController = UIAlertController(title:"Confirmation Message",
                    message: "Payment Saved",
                    preferredStyle: .Alert)
                let tryAgainAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
                    self.navigationController?.popToRootViewControllerAnimated(true)
                })
                alertController.addAction(tryAgainAction)
                  self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                // No user is signed in
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardNumber.text = "4444 5555 6666 7777"
        self.nameOnCArd.text = "Nicole Klein"
        self.expirationDate.text = "10/18"
        self.securityCode.text = "510"
//        self.dbRef.observeAuthEventWithBlock({ authData in
//            if authData != nil {
//                // user authenticated
//                print(authData)
//                
//                let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + authData.uid)
//                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
//                    
//                    if let creditCard = snapshot.value["creditcard"] as? [String] {
//                        self.nameOnCArd.text = creditCard["nameOnCard"]
//                        self.cardNumber.text = creditCard["cardNumber"]
//                        self.expirationDate.text = creditCArd["expirationDate"]
//                        self.securityCode.text = creditCard["securityCode"]
//                    }
//                    
//               
//                    
//                })
//                
//            } else {
//                // No user is signed in
//            }
//        })
        
    }
}
