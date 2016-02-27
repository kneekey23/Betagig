//
//  BetaGigRequestController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class BetaGigRequestController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var duration: [String] = ["1","3", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return duration.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return duration[row]
    }
}
