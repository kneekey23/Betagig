//
//  CreateAccountController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//
import UIKit
import Firebase
import Foundation
import Social
import Accounts

class CreateAccountController: UIViewController, UITextFieldDelegate{
    
    @IBAction func cancelCreate(sender: AnyObject) {
              self.dismissViewControllerAnimated(true, completion: nil)
    }
  
    @IBAction func logInWithTwitter(sender: AnyObject) {
        let ref = Firebase(url: "https://betagig1.firebaseio.com")
        let twitterAuthHelper = TwitterAuthHelper(firebaseRef: ref, twitterAppId: "3711213326-9ABwY8MVRIf6JgCgd7QumFC4rUDIJyqqUEGWWEb")
        twitterAuthHelper.selectTwitterAccountWithCallback { error, accounts in
            if error != nil {
                // Error retrieving Twitter accounts
            } else if accounts.count > 1 {
                // Select an account. Here we pick the first one for simplicity
                let account = accounts[0] as? ACAccount
                twitterAuthHelper.authenticateAccount(account, withCallback: { error, authData in
                    if error != nil {
                        // Error authenticating account
                        print(error)
                    } else {
                        // User logged in!
                        self.auth = true
                        let saveRef = Firebase(url:"https://betagig1.firebaseio.com/userData")
                        let userName = String(authData.providerData["displayName"])
                        let userData = ["name": userName]
                        saveRef.childByAppendingPath(authData.uid).setValue(userData)
                          self.performSegueWithIdentifier("createAccountSuccess", sender: nil)
                    }
                })
            }
        }

    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!

       var auth: Bool = false
    let ref = Firebase(url: "https://betagig1.firebaseio.com")
    
    @IBAction func createAccount(sender: AnyObject) {
        ref.createUser(emailAddress.text!, password: password.text!,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                    self.DisplayErrorAlert("")
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                    self.auth = true
                    
                    let saveRef = Firebase(url:"https://betagig1.firebaseio.com/userData")
                    let userData = ["name": self.firstName.text! + " " + self.lastName.text!]
                    saveRef.childByAppendingPath(uid).setValue(userData)
                    
                    self.performSegueWithIdentifier("createAccountSuccess", sender: nil)
                 
                }
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddress.delegate = self
        lastName.delegate = self
        firstName.delegate = self
        password.delegate = self
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