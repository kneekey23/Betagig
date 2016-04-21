//
//  Category.swift
//  Betagig
//
//  Created by Melissa Hargis on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category {
    
    
   
    var name : String?
    var id : String?
    var careers : [String]
    var careerDetails: [Career]
    
    required init?(json: JSON) {
        
        name = json["name"].stringValue
        id = json["id"].stringValue
        careers = []
        careerDetails = []
        
    }
    

    

    
}