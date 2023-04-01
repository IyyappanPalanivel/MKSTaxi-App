//
//  BookingModel.swift
//  MKSTaxi App
//
//  Created by develop on 23/03/22.
//

import Foundation
import SwiftyJSON


struct BookingModel: SwiftJson {
    
    var id : Int = Int()
    var customer_id : Int = Int()
    var customer_name: String = String()
    var pickup_address: String = String()
    var drop_address: String = String()
    var location_id: Int = Int()
    var pickup_date: String = String()
    var drop_date: String = String()
    var trip_status: String = String()
    var price : String = String()
    
    var drop: String = String()
    var pickup: String = String()
    var vehicle_type : Int = Int()
    var vehicle_name: String = String()
    var booking_id : String = String()
    var booking_status : String = String()
    var isCancel : Bool = Bool()
    var driver_Details : DriverDetailModel = DriverDetailModel()
    var driver_vechicle : DrivervehicleModel = DrivervehicleModel()
    var order_status: String = String()
    var is_cancel: Int = Int()
    var offer: String = String()
    init() {}
    
    init(json: JSON) {
        self.offer = json["offer"].string ?? String()
        self.is_cancel = json["is_cancel"].int ?? Int()
        self.order_status = json["order_status"].string ?? String()
        id  = json["id"].int ?? Int()
        vehicle_type = json["vehicle_type"].int ?? Int()
        customer_id  = json["customer_id"].int ?? Int()
        customer_name  = json["customer_name"].string ?? String()
        self.pickup_address = json["pickup_address"].string ?? String()
        self.drop_address = json["drop_address"].string ?? String()
        location_id  = json["location_id"].int ?? Int()
        self.pickup_date = json["pickup_date"].string ?? String()
        self.drop_date = json["drop_date"].string ?? String()
        trip_status = json["trip_status"].string ?? String()
        price  = json["price"].string ?? String()
        
        self.drop = json["drop"].string ?? String()
        pickup = json["pickup"].string ?? String()
        booking_id  = json["booking_id"].string ?? String()
        booking_status = json["booking_status"].string ?? String()
        vehicle_name = json["vehicle_name"].string ?? String()
        isCancel = json["is_cancel"].bool ?? Bool()
        driver_Details = DriverDetailModel(json: json["driverdetails"])
        driver_vechicle = DrivervehicleModel(json: json["drivervehicle"])
    }
}


struct DriverDetailModel {
    
    var alt_mobile   : String = String()
    var car_type          : String = String()
    var name       : String = String()
    var id                : Int = Int()
    var mobile         : String = String()
    var model_year        : String = String()
    var registration_no   : String = String()
    var vehicle_model     : String = String()
    
    init() {
    }
    init(json: JSON) {
        
        alt_mobile = json["alt_mobile"].string ?? String()
        car_type = json["car_type"].string ?? String()
        name  = json["name"].string ?? String()
        mobile = json["mobile"].string ?? String()
        
        model_year  = json["model_year"].string ?? String()
        registration_no = json["registration_no"].string ?? String()
        vehicle_model  = json["vehicle_model"].string ?? String()
        
        id = json["id"].int ?? Int()
        
    }
}
struct DrivervehicleModel {
    
    var registration_no   : String = String()
    var vehicle_name          : String = String()
    var car_model_name       : String = String()
  
    
    init() {
    }
    init(json: JSON) {
        
        registration_no = json["registration_no"].string ?? String()
        vehicle_name = json["vehicle_name"].string ?? String()
        car_model_name  = json["car_model_name"].string ?? String()
       
        
    }
}
