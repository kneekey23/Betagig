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
    
    var durationArray: [String] = ["1","3", "5"]
    var selectedCompany: Company?
    var selectedCareer: String?
      let ref = Firebase(url: "https://betagig1.firebaseio.com/betagigs")
     let dbRef = Firebase(url: "https://betagig1.firebaseio.com")
    
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
                    print(authData)
                    
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
                        
                        
                        let newBetaGig = ["id": newId, "company": (self.selectedCompany?.name)!, "gig": self.selectedCareer!, "status": "pending", "date": "Mar 9 - 11, 2016", "time": "10:00 AM - 6:00 PM", "contact": "Aiko Rogers", "cost": (self.selectedCompany?.cost)!, "street": (self.selectedCompany?.street)!, "city": (self.selectedCompany?.city)!, "state": (self.selectedCompany?.state)!, "zip": (self.selectedCompany?.zip)!, "testerid" : String(authData.uid), "testername" : testername, "testeremail" : testeremail, "lat" : (self.selectedCompany?.lat)!, "long" : (self.selectedCompany?.long)!]
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
    
    func goBackToRoot(){
        self.navigationController?.popToRootViewControllerAnimated(true)
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
