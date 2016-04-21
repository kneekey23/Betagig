//
//  Company.swift
//  Betagig
//
//  Created by Melissa Hargis on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import SwiftyJSON

class Company {
    
   var longDesc : String?
   var imageUrl : String?
   var zip : Int?
   var street : String?
   var lat : Double?
   var tablePrefix : String?
   var tableName : String?
   var costPerDay : Int?
   var city : String?
   var id : String?
   var state : String?
   var isDeleted : String?
   var long : Double?
   var isVisible : String?
   var gigCareers : [AnyObject]?
   var name : String?
   var shortDesc : String?
    
    
    required init?(json: JSON) {
        
        name = json["name"].stringValue
        gigCareers = json["gigCareers"].arrayObject
        street = json["street"].stringValue
        city = json["city"].stringValue
        state = json["state"].stringValue
        zip = json["zip"].intValue
        costPerDay = json["costPerDay"].intValue
        shortDesc = json["shortDesc"].stringValue
        longDesc = json["longDesc"].stringValue
        imageUrl = json["imageUrl"].stringValue
        lat = json["lat"].doubleValue
        long = json["long"].doubleValue
        
    }
    

    
    
//    init (name: String, gigs: [String], region: String, street: String, city: String, state: String, zip: String, cost: Int, shortdesc: String, longdesc: String, image: String, lat: String, long: String, key: String = "") {
//        
//        self.name = name
//        self.gigs = gigs
//        self.region = region
//        self.street = street
//        self.city = city
//        self.state = state
//        self.zip = zip
//        self.cost = cost
//        self.shortdesc = shortdesc
//        self.longdesc = longdesc
//        self.image = image
//        self.lat = lat
//        self.long = long
//        self.key = key
//        self.ref = nil
//    }
    
}