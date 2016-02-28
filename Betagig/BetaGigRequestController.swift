//
//  BetaGigRequestController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class BetaGigRequestController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    var durationArray: [String] = ["1","3", "5"]
    var selectedCompany: Company?
    var selectedCareer: String?
      let ref = Firebase(url: "https://betagig1.firebaseio.com/betagigs")
    @IBAction func requestAction(sender: AnyObject) {
        
        // Attach a closure to read the data
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var betagigs = [BetaGig]()
            
            for item in snapshot.children {
                let betagig = BetaGig(snapshot: item as! FDataSnapshot)
                betagigs.append(betagig)
            }
            
            let newId = String(betagigs.count)
            
            let newBetaGig = ["id": newId, "company": (self.selectedCompany?.name)!, "gig": self.selectedCareer!, "status": "pending", "date": "March 9, 2016 - March 11, 2016", "time": "10:00 AM - 6:00 PM", "contact": "Aiko Rogers", "cost": (self.selectedCompany?.cost)!, "street": (self.selectedCompany?.street)!, "city": (self.selectedCompany?.city)!, "state": (self.selectedCompany?.state)!, "zip": (self.selectedCompany?.zip)!]
            
            self.ref.childByAppendingPath(newId).setValue(newBetaGig)
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
    }
    @IBOutlet weak var duration: UIPickerView!
    @IBOutlet weak var companyNote: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNote.delegate = self
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
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
