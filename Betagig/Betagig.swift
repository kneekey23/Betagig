//
//  Betagig.swift
//  Betagig
//
//  Created by Nicki on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import Firebase

class BetaGig {
    
    var id: String = ""
    var company: String = ""
    var gig: String = ""
    var status: String = ""
    var date: String = ""
    var time: String = ""
    var contact: String = ""
    var cost: Double = 50.00
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
    let ref: Firebase?
    let key: String!
    
    
    init(snapshot: FDataSnapshot) {
        
        key = snapshot.key
        ref = snapshot.ref
        id = snapshot.value["id"] as! String
        company = snapshot.value["company"] as! String
        gig = snapshot.value["gig"] as! String
        status = snapshot.value["status"] as! String
        date = snapshot.value["date"] as! String
        time = snapshot.value["time"] as! String
        contact = snapshot.value["contact"] as! String
        cost = snapshot.value["cost"] as! Double
        street = snapshot.value["street"] as! String
        city = snapshot.value["city"] as! String
        state = snapshot.value["state"] as! String
        zip = snapshot.value["zip"] as! String
    }
    
    
    func toAnyObject() -> AnyObject {
        
        return [
            "id": id,
            "company": company,
            "gig": gig,
            "status": status,
            "date": date,
            "time": time,
            "contact": contact,
            "cost": cost,
            "street": street,
            "city": city,
            "state": state,
            "zip": zip
        ]
        
    }
    
    
    init (id: String, company: String, gig: String, status: String, date: String, time: String, contact: String, cost: Double, street: String, city: String, state: String, zip: String, key: String = "") {
        self.id = id
        self.company = company
        self.gig = gig
        self.status = status
        self.date = date
        self.time = time
        self.contact = contact
        self.cost = cost
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
        self.key = key
        self.ref = nil
    }
    
}