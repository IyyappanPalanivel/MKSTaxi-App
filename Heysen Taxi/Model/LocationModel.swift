//
//  LocationModel.swift
//  MKSTaxi App
//
//  Created by develop on 26/03/22.
//

import Foundation
import SwiftyJSON


struct LocationModel: SwiftJson {
    
    var id  : Int = Int()
    var name : String = String()
    var code : String = String()
    var latitude : String = String()
    var longitude : String = String()
    var status : String = String()
    
    init() {}
    init(json: JSON) {
        id  = json["id"].int ?? Int()
        name  = json["name"].string ?? String()
        code = json["code"].string ?? String()
        latitude = json["latitude"].string ?? String()
        longitude = json["longitude"].string ?? String()
        status = json["status"].string ?? String()
    }
}
