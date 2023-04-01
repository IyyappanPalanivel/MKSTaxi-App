//
//  ApiclientError.swift
//  HyraApp
//
//  Created by muthuraja on 24/04/21.
//

import Foundation
import ObjectMapper
import SwiftyJSON

enum ApiclientError: Error {
    case noInternet
    case dominError
    case decodingError
    case encodingError
    case custom(ErrorModel)
}
    

extension ApiclientError: LocalizedError {
    var errDesc: String? {
        switch self {
        case .noInternet:
            return Constant.MainError.internetError
        case .dominError:
            return Constant.MainError.domainError
        case .decodingError:
            return Constant.MainError.decodingError
        case .encodingError:
            return Constant.MainError.encodingErrorr
        case .custom(let error):
            return error.msg
        }
    }
}

struct ErrorModel {
    var msg : String = String()
    
    init() {}
    init(json: JSON) {
        msg = json["message"].string ?? String()
    }
}
