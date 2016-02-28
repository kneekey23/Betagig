//
//  User.swift
//  Betagig
//
//  Created by Melissa Hargis on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    var name: String = ""
    var betagigs: [Int] = []
    let ref: Firebase?
    let key: String!
    
    init(snapshot: FDataSnapshot) {
        
        key = snapshot.key
        ref = snapshot.ref
        name = snapshot.value["name"] as! String
        betagigs = snapshot.value["betagigs"] as! [Int]
    }
    
    
    func toAnyObject() -> AnyObject {
        
        return [
            "company": name,
            "betagigs": betagigs,
        ]
        
    }
    
    
    init (name: String, betagigs: [Int], key: String = "") {
        self.name = name
        self.betagigs = betagigs
        self.key = key
        self.ref = nil
    }
}