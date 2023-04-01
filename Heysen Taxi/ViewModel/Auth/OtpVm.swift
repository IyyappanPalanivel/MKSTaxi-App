//
//  OtpVm.swift
//  MKSTaxi App
//
//  Created by develop on 20/03/22.
//

import Foundation


class OtpVm {
    
    var successHandler :  ((BaseModel) -> ())?
    var errorHandler : ((String) -> ())?
    
    typealias Credential = (mobile: String, otp: String, device: String, mobile_token : String, role_id: Int)
    
    func OtpApi(with credential: Credential) {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth
                                                    .verifyOTP)
        resource.httpMethod = .post
        resource.params = ["mobile": credential.mobile, "otp": credential.otp, "device": credential.device, "mobile_token": credential.mobile_token, "role_id": "2"]
        ApiMager.share.Apireqauest(withResources: resource) { (result) in
            switch result {
            case .success(let baseModel):
                print("newww value tokennn:\(baseModel.token)")
              
                self.successHandler?(baseModel)
            case .failure(let error):
                self.errorHandler?(error.errDesc ?? "")
            }
        }
    }
}

