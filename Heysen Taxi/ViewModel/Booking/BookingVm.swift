//
//  BookingVm.swift
//  MKSTaxi App
//
//  Created by develop on 20/03/22.
//

import Foundation


class BookingVm {
    
    var successHandler :  ((BaseModel) -> ())?
    var errorHandler : ((String) -> ())?
    
   
    func getBookingDetails() {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.booking)
        resource.httpMethod = .get
        ApiMager.share.Apireqauest(withResources:  resource) { (result) in
            switch result {
            case .success(let baseModel):
                self.successHandler?(baseModel)
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }
}
extension BookingVm {
    func cancelbooking(with bookingId : String) {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.booking)
        resource.params = ["booking_id": bookingId, "status": "rejected_cus"]
        resource.httpMethod = .patch
        ApiMager.share.Apireqauest(withResources: resource) { (result) in
            switch result {
            case .success(let baseModel):
                self.successHandler?(baseModel)
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }
}


