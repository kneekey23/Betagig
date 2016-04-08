//
//  Betagig.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import SwiftyJSON

class BetaGig {
    
   var testerUserId : String?
   var companyName : String?
   var lat : Double?
   var companyZip : Int?
   var testerName : String?
   var tablePrefix : String?
   var tableName : String?
   var status : String?
   var time : String?
   var id : String?
   var isDeleted : String?
   var companyState : String?
   var managerApproved : String?
   var testerEmail : String?
   var long : Double?
   var careerName : String?
   var companyContactUserId : String?
   var careerId : String?
   var costPerDay: Int?
   var companyStreet : String?
    var companyCity : String?
    

    required init?(json: JSON) {
        
        testerUserId = json["testerUserId"].stringValue
        companyName = json["companyName"].stringValue
        lat = json["lat"].doubleValue
        companyZip = json["companyZip"].intValue
        testerName = json["testerName"].stringValue
        tablePrefix = json["tablePrefix"].stringValue
        tableName = json["tableName"].stringValue
        status = json["status"].stringValue
        time = json["time"].stringValue
        id = json["id"].stringValue
        isDeleted = json["isDeleted"].stringValue
        companyState = json["companyState"].stringValue
        managerApproved = json["managerApproved"].stringValue
        testerEmail = json["testerEmail"].stringValue
        long = json["long"].doubleValue
        careerName = json["careerName"].stringValue
        companyContactUserId = json["companyContactUserId"].stringValue
        careerId = json["careerId"].stringValue
        companyStreet = json["companyStreet"].stringValue
    }
    
    init(){
        
    }
    

    
}
