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
    var careeerId: String?
    
    @IBAction func bestTestGig(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "requestSegue"{
          let betagigRequestController = segue.destinationViewController as! BetaGigRequestController
            
            betagigRequestController.selectedCompany = company
            betagigRequestController.selectedCareer = career
            betagigRequestController.selectedCareerId = careeerId
        }
    }
    
    func setFields() {
        var addressText = (company?.street)!
        addressText += "\n" + (company?.city)!
        addressText += ", " + (company?.state)!
        addressText += " " + String(company?.zip)
        address.text = addressText
        duration.text = "1, 3, or 5 days"
        companyTitle.text = company!.name
        companyDesc.text = company!.longDesc
        companyImage.image = UIImage(named: company!.imageUrl!)
        let costText = "$" + String(company!.costPerDay!) + "/per day"
        cost.text = costText
        gigs.text = career!
    }
}
