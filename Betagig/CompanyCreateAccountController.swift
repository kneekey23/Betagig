//
//  CompanyCreateAccountController.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class CompanyCreateAccountController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var companyDescription: UITextView!
    @IBOutlet weak var companyZip: UITextField!
    @IBOutlet weak var companyState: UITextField!
    @IBOutlet weak var companyCity: UITextField!
    @IBOutlet weak var companyAddress: UITextField!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var companyEmail: UITextField!
    @IBAction func closeModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        companyAddress.delegate = self
        companyCity.delegate = self
        companyEmail.delegate = self
        companyState.delegate = self
        companyZip.delegate = self
        companyDescription.delegate = self
        companyName.delegate = self
        password.delegate = self
    }

    //adds the ability to get rid of they keyboard for any text field on return.NJK
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
