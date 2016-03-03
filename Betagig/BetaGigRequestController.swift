//
//  BetaGigRequestController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class BetaGigRequestController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, BetaGigRequestDelegate {
    
    @IBOutlet weak var gigLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    var durationArray: [String] = ["1","3", "5"]
    var selectedCompany: Company?
    var selectedCareer: String?
      let ref = Firebase(url: "https://betagig1.firebaseio.com/betagigs")
     let dbRef = Firebase(url: "https://betagig1.firebaseio.com")
    
    @IBOutlet weak var durationTextField: UITextField!
 
    @IBAction func popDurationPicker(sender: UITextField) {
        
    }
    @IBAction func popStartDatePicker(sender: UITextField) {
        
        //Create the view
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneStartDateButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: Selector("startDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
       // handleStartDatePicker(datePickerView) // Set the date on start.
    }
    
    @IBAction func popEndDatePicker(sender: UITextField) {
        
        //Create the view
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneEndDateButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: Selector("endDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
      //  handleEndDatePicker(datePickerView) // Set the date on start.
    }
    @IBAction func requestAction(sender: AnyObject) {
        
        // Attach a closure to read the data
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var betagigs = [BetaGig]()
            
            for item in snapshot.children {
                let betagig = BetaGig(snapshot: item as! FDataSnapshot)
                betagigs.append(betagig)
            }
            
            let newId = String(betagigs.count)
            
            
            //add beta gig id to users list of beta gigs.
            self.dbRef.observeAuthEventWithBlock({ authData in
                if authData != nil {
                    // user authenticated
                    
                    
                    let userUrl = Firebase(url: "https://betagig1.firebaseio.com/userData/" + authData.uid)
                    
                    userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
                        
                        if var ids = snapshot.value["betagigs"] as? [String] {
                           ids.append(newId)
                            let newIdObj = [newId: newId]
                            userUrl.childByAppendingPath("betagigs").updateChildValues(newIdObj)
                        }
                       
                        var testername: String = ""
                        if let userName = snapshot.value["name"] as? String {
                            print(userName)
                            testername = userName
                        }
                        
                        var testeremail: String = ""
                        if let userEmail = snapshot.value["email"] as? String {
                            print(testeremail)
                            testeremail = userEmail
                        }
                        
                        
                        let newBetaGig = ["id": newId, "company": (self.selectedCompany?.name)!, "gig": self.selectedCareer!, "status": "pending", "date": "March 9, 2016 - March 11, 2016", "time": "10:00 AM - 6:00 PM", "contact": "Aiko Rogers", "cost": (self.selectedCompany?.cost)!, "street": (self.selectedCompany?.street)!, "city": (self.selectedCompany?.city)!, "state": (self.selectedCompany?.state)!, "zip": (self.selectedCompany?.zip)!, "testerid" : String(authData.uid), "testername" : testername, "testeremail" : testeremail, "lat" : (self.selectedCompany?.lat)!, "long" : (self.selectedCompany?.long)!]
                        //add beta gigs to beta gig table.
                        self.ref.childByAppendingPath(newId).setValue(newBetaGig)
                    })
                    
                } else {
                    // No user is signed in
                }
            })
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
    }
    @IBOutlet weak var duration: UIPickerView!
    @IBOutlet weak var companyNote: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNote.delegate = self
        self.companyLabel.text = selectedCompany?.name
        self.gigLabel.text = selectedCareer
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(hexString: "B048B5")
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        

        durationTextField.inputAccessoryView = toolBar
        
        durationTextField.inputView = pickerView
    }

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durationArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return durationArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        durationTextField.text = durationArray[row]
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func goBackToRoot(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func endDatePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        endDateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func startDatePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        startDateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    
    func doneStartDateButton(sender:UIButton)
    {
        startDateTextField.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    func doneEndDateButton(sender:UIButton)
    {
        endDateTextField.resignFirstResponder() // To resign the inputView on clicking done.
    }
    func donePicker()
    {
        durationTextField.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    func goBackToMyBetaGigs() {
        
        tabBarController?.selectedIndex = 1
        let firstNavController: UINavigationController = tabBarController?.selectedViewController as! UINavigationController;
        firstNavController.popToRootViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "successSegue" {
            let secondController = segue.destinationViewController as! BetaGigSuccessController
            secondController.delegate = self
        }
    }
    


}
