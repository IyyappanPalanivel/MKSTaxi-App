//
//  SignUpVm.swift
//  MKSTaxi App
//
//  Created by develop on 20/03/22.
//

import Foundation

class RegisterVm {
    
    var successHandler :  ((String) -> ())?
    var errorHandler : ((String) -> ())?
    
    typealias Credentials = (name: String, email: String, mobile: String, role_id: Int, device: String, dob: String, gender: String)
    
    func RegisterApi(with credential: Credentials) {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.signup)
        resource.httpMethod = .post
        
        resource.params = ["name": credential.name, "email" : credential.email, "mobile" : credential.mobile, "role_id": "2", "device": credential.device, "dob" : credential.dob, "gender": credential.gender ]
        
        ApiMager.share.Apireqauest(withResources:  resource) { (result) in
            switch result {
            case .success(let baseModel):
                print("values::::", baseModel.message)
                if baseModel.message == "Registered successfully please verify otp received on your mobile." {
                    self.successHandler?(baseModel.message)
                } else {
                    self.errorHandler?(baseModel.message)
                }
                
            case .failure(let error):
                print("errorr:::", error.errDesc)
                self.errorHandler?(error.errDesc ?? "")
            }
        }
    }
}



