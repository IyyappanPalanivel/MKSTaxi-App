//
//  FareListModel.swift
//  MKSTaxi App
//
//  Created by develop on 23/03/22.
//

import Foundation

import SwiftyJSON


struct FareListModel: SwiftJson {
    
    var id  : Int = Int()
    var name : String = String()
    var one_way_price : String = String()
    var round_trip_price : String = String()
    var seats : String = String()
    var carnames : String = String()
    var vehiclename : String = String()
    var duratio: String = String()
    var price : String = String()
    var base_oneway_fare: String = String()
    var base_round_fare : String = String()
    var driver_oneway_fare: String = String()
    var driver_round_fare: String = String()
    var oneway_price: String = String()
    var round_price : String = String()
    var trip_covers : String = String()
    var noOfDays : Int = Int()
    var vehicleimage : String = String()
    
    init() {}
    init(json: JSON) {
        vehicleimage = json["vehicleimage"].string ?? String()
        oneway_price = json["oneway_price"].string ?? String()
        round_price = json["round_price"].string ?? String()
        base_round_fare = json["base_round_fare"].string ?? String()
        driver_oneway_fare = json["driver_oneway_fare"].string ?? String()
        driver_round_fare = json["driver_round_fare"].string ?? String()
        id  = json["id"].int ?? Int()
        noOfDays = json["noOfDays"].int ?? Int()
        name  = json["name"].string ?? String()
        one_way_price = json["one_way_price"].string ?? String()
        round_trip_price = json["round_trip_price"].string ?? String()
        seats = json["seats"].string ?? String()
        carnames = json["carnames"].string ?? String()
        vehiclename = json["vehiclename"].string ?? String()
        duratio = json["duration"].string ?? String()
        price = json["price"].string ?? String()
        base_oneway_fare = json["base_oneway_fare"].string ?? String()
        trip_covers = json["trip_covers"].string ?? String()
    }
    
    
}
