//
//  ViewController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import AWSCore


class AuthenticationController: UIViewController,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var closeBtn: UIButton!

    
       var auth: Bool = false

    @IBAction func login(sender: AnyObject) {
        let loginButton: UIButton = sender as! UIButton
        loginButton.setTitle("Loading...", forState: UIControlState.Normal)
//        ref.authUser(username.text, password: password.text) {
//            error, authData in
//            if error != nil {
//                // an error occured while attempting login
//                
//                self.auth = false
//                if(!self.auth){
//                    self.DisplayErrorAlert("")
//                }
//                
//                // by default, transition
//                
//            } else {
//                self.auth = true
//                self.performSegueWithIdentifier("browse", sender: nil)
//                // user is logged in, check authData for data
//            }
//        }
        AmazonCognitoManager.sharedInstance.loginFromView(self, provider: "betagig", username: username.text!, password: password.text!) {
            (task: AWSTask!) -> AnyObject! in
            dispatch_async(dispatch_get_main_queue()) {
                   self.auth = true
                 self.performSegueWithIdentifier("browse", sender: nil)
            }
            return nil
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        closeBtn!.addTarget(self, action: #selector(AuthenticationController.tapOnX(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        username.delegate = self
        password.delegate = self
        username.text = "nicki@betagig.com"
        password.text = "goucla23"
    }
    
    func tapOnX(button: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("loginCell", forIndexPath: indexPath) as! StaticTableCell
        
        cell.textField = UITextField()
      
        
        if indexPath.row == 0{
            cell.textField.placeholder = "Email Address"
        }
        else{
            cell.textField.placeholder = "Password"
            cell.textField.secureTextEntry = true
        }
        
        return cell
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        
        if identifier == "login" {
            return auth
        } else if identifier == "createAccount"{
            auth = true
        } else if identifier == "companySignIn"{
            auth = true
        } else if identifier == "giftSegue"{
            auth = true
        }
        
        return auth
    }
    


    //adds the ability to get rid of they keyboard for any text field on return.NJK
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    func DisplayErrorAlert(var errorMessage: String)
    {
        if(errorMessage.isEmpty){
            errorMessage = "We weren't able to log you in. Did you forget your password? We recommend getting sleep to help with memory loss"
        }
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
            //self.navigationController?.popToRootViewControllerAnimated(true)
        })
        alertController.addAction(tryAgainAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

}

