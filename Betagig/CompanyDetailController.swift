//
//  CompanyDetailController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class CompanyDetailController: UIViewController {

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var companyTitle: UILabel!
    @IBOutlet weak var companyDesc: UITextView!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var gigs: UILabel!
    
    var company: Company?
    var career: String?
    
    @IBAction func bestTestGig(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
    }
    
    func setFields() {
        let addressText = company!.street + "\n" + company!.city + ", " + company!.state + " " + company!.zip
        address.text = addressText
        duration.text = "1, 3, or 5 days"
        companyTitle.text = company!.name
        companyDesc.text = company!.longdesc
        companyImage.image = UIImage(named: company!.image)
        let costText = "$" + String(company!.cost) + "/per day"
        cost.text = costText
        gigs.text = career!
    }
}
