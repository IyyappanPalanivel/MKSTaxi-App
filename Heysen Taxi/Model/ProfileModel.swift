//
//  ProfileModel.swift
//  MKSTaxi App
//
//  Created by develop on 22/03/22.
//

import Foundation
import SwiftyJSON


struct ProfileModel: SwiftJson {
    
    var id : Int = Int()
    var role : Int = Int()
    var name: String = String()
    var email: String = String()
    var mobile: String = String()
    var location_id: Int = Int()
    var avatar: String = String()
    var dob : String = String()
    var status: String = String()
    var email_verified_at: String = String()
    var role_id : Int = Int()
    var gender : String = String()
    
    init() {}
    
    init(json: JSON) {
        id  = json["id"].int ?? Int()
        role  = json["role"].int ?? Int()
        name  = json["name"].string ?? String()
        self.email = json["email"].string ?? String()
        self.mobile = json["mobile"].string ?? String()
        location_id  = json["location_id"].int ?? Int()
        self.avatar = json["avatar"].string ?? String()
        self.status = json["status"].string ?? String()
        email_verified_at = json["email_verified_at"].string ?? String()
        role_id  = json["role_id"].int ?? Int()
        dob = json["dob"].string ?? String()
        gender = json["gender"].string ?? String()
    }
}



