//
//  ConfirmBookingModel.swift
//  Heysen Taxi
//
//  Created by develop on 09/12/22.
//

import Foundation
import UIKit
import ObjectMapper

struct ConfirmBookingModel: Mappable {
    
    var function : String = String()
    var trip_type : String = String()
    var pickup_location : String = String()
    var drop_location : String = String()
    var pickup_date : String = String()
    var vehicle_type : String = String()
    var optional_mobile : String = String()
    var customer_name : String = String()
    var pickup_address : String = String()
    var drop_address : String = String()
    var drop_date : String = String()
    var drop_lat : String = String()
    var drop_lang : String = String()
    var pickup_lat : String = String()
    var pickup_lang : String = String()
    var pickup : String = String()
    var drop : String = String()
    var promo_code: String = String()
    
    init() {
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        promo_code    <- map["promo_code"]
        function     <- map["function"]
        trip_type <- map["trip_type"]
        pickup_location <- map["pickup_location"]
        drop_location <- map["drop_location"]
        pickup_date <- map["pickup_date"]
        vehicle_type <- map["vehicle_type"]
        optional_mobile <- map["optional_mobile"]
        customer_name <- map["customer_name"]
        pickup_address <- map["pickup_address"]
        drop_address <- map["drop_address"]
        drop_date <- map["drop_date"]
        drop_lat <- map["drop_lat"]
        drop_lang <- map["drop_lang"]
        pickup_lat <- map["pickup_lat"]
        pickup_lang <- map["pickup_lang"]
        pickup <- map["pickup"]
        drop <- map["drop"]
    }
}
