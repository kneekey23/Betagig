//
//  CreateAccountController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//
import UIKit

import Foundation
import Social
import Accounts

class CreateAccountController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBAction func cancelCreate(sender: AnyObject) {
              self.dismissViewControllerAnimated(true, completion: nil)
    }
  
    @IBAction func logInWithTwitter(sender: AnyObject) {


    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!

       var auth: Bool = false

    
    @IBAction func createAccount(sender: AnyObject) {

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeBtn!.addTarget(self, action: #selector(CreateAccountController.tapOnX(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        emailAddress.delegate = self
        lastName.delegate = self
        firstName.delegate = self
        password.delegate = self
    }
    
    func tapOnX(button: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        
        
        return auth
    }
    
    func DisplayErrorAlert(var errorMessage: String)
    {
        if(errorMessage.isEmpty){
            errorMessage = "We weren't able to create an account for you. Please try again."
        }
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
            //self.navigationController?.popToRootViewControllerAnimated(true)
        })
        alertController.addAction(tryAgainAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
}