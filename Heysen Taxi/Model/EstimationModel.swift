//
//  EstimationModel.swift
//  MKSTaxi App
//
//  Created by develop on 06/04/22.
//

import Foundation
import ObjectMapper

struct EstimationModel: Mappable {
    
    var function    :  String = String()
    var trip_type   :  String = String()
    var pickup      :  String = String()
    var drop        :  String = String()
    var pickup_date :  String = String()
    var drop_date   :  String = String()
    var pickAddress :  String = String()
    var dropAddress :  String = String()
    
    var drop_lang   :  String = String()
    var drop_lat    :  String = String()
    var pickup_lat  :  String = String()
    var pickup_lang :  String = String()
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        function    <- map["function"]
        trip_type   <- map["trip_type"]
        pickAddress <- map["pickup"]
        dropAddress <- map["drop"]
        pickup      <- map["pickup_location"]
        drop        <- map["drop_location"]
        pickup_date <- map["pickup_date"]
        drop_date   <- map["drop_date"]
        
        drop_lang <- map["drop_lang"]
        drop_lat   <- map["drop_lat"]
        pickup_lat <- map["pickup_lat"]
        pickup_lang   <- map["pickup_lang"]
        
    }
    
    init() {
    }
    
}

