//
//  TarrifModel.swift
//  MKSTaxi App
//
//  Created by develop on 22/03/22.
//

import Foundation
import SwiftyJSON

struct TarrifModel: SwiftJson {
    
    var id : Int = Int()
    var name : String   = String()
    var one_way_price   : String    = String()
    var round_trip_price : String   = String()
    var vehiclename   : String    = String()
    var seats : String = String()
    var carnames : String = String()
    
    init() {}
    
    init(json: JSON) {
        self.carnames = json["carnames"].string ?? String()
        id = json["id"].int ?? Int()
        name = json["name"].string ?? String()
        one_way_price   = json["one_way_price"].string ?? String()
        round_trip_price = json["round_trip_price"].string ?? String()
        vehiclename   = json["vehiclename"].string ?? String()
        seats = json["seats"].string ?? String()

    }
}


