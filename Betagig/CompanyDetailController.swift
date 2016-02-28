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
    
    @IBAction func bestTestGig(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
    }
    
    func setFields() {
        let addressText = company!.street + "\n" + company!.city + ", " + company!.state + " " + company!.zip
        address.text = addressText
        duration.text = "1 day, 3 days, or 5 days"
        companyTitle.text = company!.name
        companyDesc.text = company!.longdesc
        companyImage.image = UIImage(named: company!.image)
        let costText = String(company!.cost)
        cost.text = costText
        var gigsText: String = ""
        var count: Int = 0
        for g in company!.gigs {
            gigsText += g
            if count != company!.gigs.count - 1 {
                gigsText += ", "
            }
            count++
        }
    }
}
