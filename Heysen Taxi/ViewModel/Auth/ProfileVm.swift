//
//  ProfileVm.swift
//  MKSTaxi App
//
//  Created by develop on 20/03/22.
//

import Foundation


class ProfileVm {
    
    var successHandler :  ((BaseModel) -> ())?
    var errorHandler : ((String) -> ())?
    
   
    func getProfile() {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.profile + "device=ios")
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
    
    func deleteFunc() {
        var resources = CodeResources<BaseModel>(url: URlNetwork.Auth.delete)
        resources.httpMethod = .post
        resources.params = ["device": "ios"]
        ApiMager.share.Apireqauest(withResources: resources) { result in
            switch result {
            case .success(let baseModel):
                self.successHandler?(baseModel)
            case .failure(let error):
                self.errorHandler?(error.errDesc ?? "")
            }
        }
    }
}
extension ProfileVm  {
    
    typealias Credentials = (name: String, email: String, mobile: String, dob: String, gender: String)
    
    func updateProfile(with credential: Credentials) {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.profile + "device=ios")
        resource.httpMethod = .patch
        
        resource.params = ["name": credential.name, "email" : credential.email, "mobile" : credential.mobile, "dob" : credential.dob, "gender": credential.gender ]
        print("Params::::", resource.params)
        ApiMager.share.Apireqauest(withResources: resource) { (result) in
            switch result {
            case .success(let baseModel):
                self.successHandler?(baseModel)
            case .failure(let error):
                print("error:::", error.errDesc)
                self.errorHandler?(error.errDesc ?? "")
            }
        }
    }
    
}
