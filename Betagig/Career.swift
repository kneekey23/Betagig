//
//  Career.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import SwiftyJSON

class Career {
    
    var id : String?
    var categoryId : String?
    var title : String?
    var iconUrl : String?
    var minCost: Int?
    var maxCost: Int?
    var numBetagigs: Int?
    
    
    
    
   required init?(json: JSON) {
        
        id = json["id"].stringValue
        
        title = json["title"].stringValue
        
        iconUrl = json["iconUrl"].stringValue
        
        categoryId = json["categoryId"].stringValue

    }
    
    init (title: String, iconUrl: String, categoryId: String, minCost: Int, maxCost: Int, numBetagigs: Int, id: String) {
        
        self.title = title
        
        self.iconUrl = iconUrl
        
        self.categoryId = categoryId
        
        self.minCost = minCost
        
        self.maxCost = maxCost
        
        self.numBetagigs = numBetagigs
        
        self.id = id
        
   
        
    }


    
}