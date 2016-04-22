//
//  BetaGigRequestController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BetaGigRequestController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, BetaGigRequestDelegate {
    
    @IBOutlet weak var gigLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    var durationArray: [String] = ["1","3", "5"]
    var selectedCompany: Company?
    var selectedCareer: String?
    var selectedCareerId: String?
    //let userId: String = "a2c1144f-6842-4249-b3cd-77bd8571cf04"
    
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
        
        doneButton.addTarget(self, action: #selector(BetaGigRequestController.doneStartDateButton(_:)), forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(BetaGigRequestController.startDatePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
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
        
        doneButton.addTarget(self, action: #selector(BetaGigRequestController.doneEndDateButton(_:)), forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(BetaGigRequestController.endDatePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
      //  handleEndDatePicker(datePickerView) // Set the date on start.
    }
    @IBAction func requestAction(sender: AnyObject) {
        
        let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/user?id=\(AmazonCognitoManager.sharedInstance.currentUserId!)";

        Alamofire.request(.GET, apiUrl, headers: Constants.headers).validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    let user = User(json: json)
                    let testername = (user?.firstName)! + " " + (user?.lastName)!
                    
                    var dict : [String: AnyObject] = [:]
                    dict["companyName"] = (self.selectedCompany?.name)!
                    dict["careerName"] = self.selectedCareer
                    dict["careerId"] = self.selectedCareerId
                    dict["startDate"] = self.startDateTextField?.text!
                    dict["endDate"] = self.startDateTextField?.text!
                    dict["time"] = "10:00AM - 6:00 PM"
                    dict["companyContactUserName"] = "Marv Marvington"
                    dict["companyContactUserId"] = "af9da2a5-77e6-421d-9894-ca7b59b57dde"
                    dict["id"] = ""
                    dict["companyStreet"] = (self.selectedCompany?.street)!
                    dict["companyCity"] = (self.selectedCompany?.city)!
                    dict["companyState"] = (self.selectedCompany?.state)!
                    dict["companyZip"] = Int((self.selectedCompany?.zip)!)
                    dict["lat"] = Double((self.selectedCompany?.lat)!)
                    dict["long"] = Double((self.selectedCompany?.long)!)
                    dict["testerName"] = testername
                    dict["testerEmail"] = user?.email
                    dict["testerUserId"] = user?.id
                    dict["costPerDay"] = (self.selectedCompany?.costPerDay)!
                    
                    let betagigUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/betagig"
                  
                    
                    Alamofire.request(.POST, betagigUrl, headers: Constants.headers, parameters: dict, encoding: .JSON)
                        .responseJSON{ response in
                            switch response.result{
                            case .Success: break
                                //self.performSegueWithIdentifier("successSegue", sender: nil)
                            case .Failure(let error):
                                 print("Request failed with error: \(error)")
                            }
                            
                    }
                
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BetaGigRequestController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BetaGigRequestController.donePicker))
        
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
