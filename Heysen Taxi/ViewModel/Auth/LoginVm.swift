//
//  LoginVm.swift
//  MKSTaxi App
//
//  Created by develop on 20/03/22.
//

import Foundation


class LoginVm {
    
    var successHandler :  ((BaseModel) -> ())?
    var errorHandler : ((String) -> ())?
    
    typealias Credentials = (mobile: String, role_id: Int, device: String)
    
    func loginApi(with credential: Credentials) {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.login)
        resource.httpMethod = .post
        resource.params = ["mobile": credential.mobile, "role_id": "2", "device": credential.device ]
        ApiMager.share.Apireqauest(withResources: resource) { (result) in
            switch result {
            case .success(let baseModel):
                print("message:::", baseModel.message)
                Alerter.sharedInstense.showtoast(withMsg: baseModel.message)
                if baseModel.message == "Please enter the OTP send to your mobile number." {
                    self.successHandler?(baseModel)
                } else {
                    self.errorHandler?(baseModel.message)
                }
                
            case .failure(let error):
                self.errorHandler?(error.errDesc ?? "")
            }
        }
    }
}
