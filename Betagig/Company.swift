//
//  Company.swift
//  Betagig
//
//  Created by Melissa Hargis on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import Firebase

class Company {
    
    var name: String = ""
    var gigs: [String] = []
    var region: String = ""
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
    var cost: Double = 150.00
    var shortdesc: String = ""
    var longdesc: String = ""
    var image: String = ""
    let ref: Firebase?
    let key: String!
    
    
    init(snapshot: FDataSnapshot) {
        
        key = snapshot.key
        ref = snapshot.ref
        name = snapshot.value["name"] as! String
        gigs = snapshot.value["gigs"] as! [String]
        region = snapshot.value["region"] as! String
        street = snapshot.value["street"] as! String
        city = snapshot.value["city"] as! String
        state = snapshot.value["state"] as! String
        zip = snapshot.value["zip"] as! String
        cost = snapshot.value["cost"] as! Double
        shortdesc = snapshot.value["shortdesc"] as! String
        longdesc = snapshot.value["longdesc"] as! String
        image = snapshot.value["image"] as! String
    }
    
    
    func toAnyObject() -> AnyObject {
        
        return [
            
            "name": name,
            "gigs": gigs,
            "region": region,
            "street": street,
            "city": city,
            "state": state,
            "zip": zip,
            "cost": cost,
            "shortdesc": shortdesc,
            "longdesc": longdesc,
            "image": image
        ]
        
    }
    
    
    init (name: String, gigs: [String], region: String, street: String, city: String, state: String, zip: String, cost: Double, shortdesc: String, longdesc: String, image: String, key: String = "") {
        
        self.name = name
        self.gigs = gigs
        self.region = region
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
        self.cost = cost
        self.shortdesc = shortdesc
        self.longdesc = longdesc
        self.image = image
        self.key = key
        self.ref = nil
    }
        
}