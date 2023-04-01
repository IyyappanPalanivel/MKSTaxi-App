//
//  FAQVm.swift
//  MKSTaxi App
//
//  Created by develop on 21/03/22.
//

import Foundation


class FAQVm {
    
    var successHandler :  ((BaseModel) -> ())?
    var errorHandler : ((String) -> ())?
    
   
    func AllDatas(with type: String) {
        var resource = CodeResources<BaseModel>(url: URlNetwork.Auth.faq + "requestdata=" + type )
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

