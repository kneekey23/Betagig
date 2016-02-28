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
    
    var name: String = ""
    var status: String = ""
    var date: String = ""
    var time: String = ""
    var pointOfContact: String = ""
    var cost: Double = 50.00
    let ref: Firebase?
    let key: String!
    
    
    init(snapshot: FDataSnapshot) {
        
        key = snapshot.key
        ref = snapshot.ref
        name = snapshot.value["name"] as! String
        status = snapshot.value["status"] as! String
        date = snapshot.value["date"] as! String
        time = snapshot.value["time"] as! String
        pointOfContact = snapshot.value["pointOfContact"] as! String
        cost = snapshot.value["cost"] as! Double
    }
    
    
    func toAnyObject() -> AnyObject {
        
        return [
            
            "name": name,
            "status": status,
            "date": date,
            "time": time,
            "pointOfContact": pointOfContact,
            "cost": cost
        ]
        
    }
    
    
    init (name: String, status: String, date: String, time: String, pointOfContact: String, cost: Double, key: String = "") {
        
        self.name = name
        self.status = status
        self.date = date
        self.time = time
        self.pointOfContact = pointOfContact
        self.cost = cost
        self.key = key
        self.ref = nil
    }
    
}
