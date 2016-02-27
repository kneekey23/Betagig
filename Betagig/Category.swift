//
//  Category.swift
//  Betagig
//
//  Created by Melissa Hargis on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import Firebase

class Category {
    
    
    
    var name: String = ""
    
    var careers: [String] = []
    
    var careerDetails: [Career?] = []
    
    let ref: Firebase?
    
    let key: String!
    
    
    
    init(snapshot: FDataSnapshot) {
        
        key = snapshot.key
        
        ref = snapshot.ref
        
        name = snapshot.value["name"] as! String
        
        careers = snapshot.value["careers"] as! [String]
        
    }
    
    
    
    func toAnyObject() -> AnyObject {
        
        return [
            
            "name": name,
            
            "careers" : careers
            
        ]
        
    }
    
    
    
    init (name: String, careers: [String], careerDetails: [Career?], key: String = "") {
        
        self.name = name
        
        self.careers = careers
        
        self.key = key
        
        self.ref = nil
        
        self.careerDetails = careerDetails
    }
    
}