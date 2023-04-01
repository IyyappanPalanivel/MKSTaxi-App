//
//  HomePageVm.swift
//  MKSTaxi App
//
//  Created by develop on 23/03/22.
//

import Foundation
import Alamofire

class HomePageVm {
    
    var successHandler :  ((BaseModel) -> ())?
    var errorHandler : ((String) -> ())?
    
   
    func Homepagedetails() {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.homepage)
        resource.httpMethod = .get
        
        ApiMager.share.Apireqauest(withResources: resource) { (result) in
            switch result {
            case .success(let baseModel):
                self.successHandler?(baseModel)
            case .failure(let error):
                self.errorHandler?(error.errDesc ?? "")
            }
        }
    }
}
extension HomePageVm {
    func estimationApi(with credential: EstimationModel) {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.booking)
        resource.params = credential.toJSON()
        print("params:::", resource.params)
        resource.httpMethod = .post
        ApiMager.share.Apireqauest(withResources: resource) { (result) in
            switch result {
            case .success(let baseModel):
                self.successHandler?(baseModel)
            case .failure(let error):
                self.errorHandler?(error.errDesc ?? "")
            }
        }
        
    }
}
extension HomePageVm {
    typealias Credential = (function: String, trip_type: String, pickup: String, drop: String, pickup_date: String, vehicle_type: Int, optional_mobile: String, customer_name: String,pickup_address: String, drop_address: String, dropDate: String, drop_lang: String, drop_lat: String, pickup_lat: String, pickup_lang: String, pickAddress: String, dropAddress: String)

    func confirmBooking(with credential: ConfirmBookingModel) {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.booking)
        print("address:::", credential.pickup)
        var params = Parameters()
        params["function"] = "booking"
        params["trip_type"] = credential.trip_type
        params["pickup_location"] = credential.pickup
        params["drop_location"] = credential.drop
        params["pickup_date"] = credential.pickup_date
        params["vehicle_type"] = credential.vehicle_type
        params["optional_mobile"] = credential.optional_mobile
        params["customer_name"] = credential.customer_name
        params["pickup_address"] = credential.pickup_address
        params["drop_address"] = credential.drop_address
        params["drop_date"] = credential.drop_date
        params["drop_lat"] = credential.drop_lat
        params["drop_lang"] = credential.drop_lang
        params["pickup_lat"] = credential.pickup_lat
        params["pickup_lang"] = credential.pickup_lang
        params["pickup"] = credential.pickup
        params["drop"] = credential.drop
        params["promo_code"] = credential.promo_code
        resource.params = params
        print("paramsss:::::", resource.params)
        resource.httpMethod = .post
        
        ApiMager.share.Apireqauest(withResources: resource) { (result) in
            switch result {
            case .success(let baseModel):
                self.successHandler?(baseModel)
            case .failure(let error):
                self.errorHandler?(error.errDesc ?? "")
            }
    }
}

}
extension HomePageVm {
    func applycoupon(with code: String) {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.promocode + code)
        resource.httpMethod = .get
        
        ApiMager.share.Apireqauest(withResources: resource) { (result) in
            switch result {
            case .success(let baseModel):
                self.successHandler?(baseModel)
            case.failure(let error):
                self.errorHandler?(error.errDesc ?? "")
            }
        }
    }
}




