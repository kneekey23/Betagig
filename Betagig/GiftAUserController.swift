//
//  GiftAUserController.swift
//  Betagig
//
//  Created by Nicki on 3/3/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class GiftAUserController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBAction func cancelGiftRequest(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var betagigUserEmailAddress: UITextField!
    @IBOutlet weak var gifterEmailAddress: UITextField!
    
    @IBOutlet weak var giftAmount: UITextField!
    
    @IBOutlet weak var creditCardName: UITextField!
    
    @IBOutlet weak var cardNumber: UITextField!
    
    @IBOutlet weak var securityCode: UITextField!
    
    @IBOutlet weak var cardExpirationDate: UITextField!
    
    @IBOutlet weak var giftNote: UITextView!
    
    @IBAction func submitGiftRequest(sender: AnyObject) {
        //show success alert
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        betagigUserEmailAddress.delegate = self
        gifterEmailAddress.delegate = self
        creditCardName.delegate = self
        cardNumber.delegate = self
        securityCode.delegate = self
        cardExpirationDate.delegate = self
        giftNote.delegate = self
        
        
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
