//
//  User.swift
//  Betagig
//
//  Created by Melissa Hargis on 2/27/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    var birthDate : String?
    var passwordHash : String?
    var id : String?
    var isDeleted : String?
    var isStudent : String?
    var agreedToTerms : String?
    var nameOfSchool : String?
    var lastName : String?
    var companyId : String?
    var referralSource : String?
    var email : String?
    var firstName : String?
    
    required init?(json: JSON) {
        
        birthDate = json["birthDate"].stringValue
        passwordHash = json["passwordHash"].stringValue
        id = json["id"].stringValue
        isDeleted = json["isDeleted"].stringValue
        isStudent = json["isStudent"].stringValue
        agreedToTerms = json["agreedToTerms"].stringValue
        nameOfSchool = json["nameOfSchool"].stringValue
        lastName = json["lastName"].stringValue
        companyId = json["companyId"].stringValue
        referralSource = json["referralSource"].stringValue
        email = json["email"].stringValue
        firstName = json["firstName"].stringValue
    }
    
    init(){
        
    }
}