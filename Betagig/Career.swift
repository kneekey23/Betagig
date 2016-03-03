//
//  Career.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import Firebase

class Career {
    
    
    
    var title: String = ""
    
    var icon: String = ""
    
    var category: String = ""
    
    var minCost: Int?
    
    var maxCost: Int?
    
    var numBetagigs: Int?
    
    let ref: Firebase?
    
    let key: String!
    
    
    
    init(snapshot: FDataSnapshot) {
        
        key = snapshot.key
        
        ref = snapshot.ref
        
        title = snapshot.value["title"] as! String
        
        icon = snapshot.value["icon"] as! String
        
        category = snapshot.value["category"] as! String
        
        minCost = snapshot.value["minCost"] as? Int
        
        maxCost = snapshot.value["maxCost"] as? Int
        
        numBetagigs = snapshot.value["maxCost"] as? Int
    }
    
    
    
    func toAnyObject() -> AnyObject {
        
        return [
            
            "title": title,
            
            "icon": icon,
            
            "category": category
        ]
        
    }
    
    
    
    init (title: String, icon: String, category: String, minCost: Int, maxCost: Int, numBetagigs: Int, key: String = "") {
        
        self.title = title
        
        self.icon = icon
        
        self.category = category
        
        self.minCost = minCost
        
        self.maxCost = maxCost
        
        self.numBetagigs = numBetagigs
        
        self.key = key
        
        self.ref = nil
        
    }
    
}