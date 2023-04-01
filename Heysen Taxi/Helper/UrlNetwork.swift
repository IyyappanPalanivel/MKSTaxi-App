//
//  UrlNetwork.swift
//  HyraApp
//
//  Created by muthuraja on 24/04/21.
//

import Foundation


struct URlNetwork {

    
    static let baseUrl = "https://heysentaxi.com/api/"
    
    struct Auth {
        static let login  = "login"
        static let signup = "register"
        static let verifyOTP = "verifyotp"
        static let profile = "userprofile?"
        static let booking = "booking"
        static let faq = "alldatas?"
        static let homepage = "homepage"
        static let promocode = "applycoupon?promo_code="
        static let delete = "deactivate"
        
//    http://lara.mkstaxi.com/api/deactivate
    }
    
}
