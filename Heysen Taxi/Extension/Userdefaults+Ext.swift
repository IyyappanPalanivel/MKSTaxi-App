//
//  Userdefaults+Ext.swift
//  HyraApp
//
//  Created by muthuraja on 24/04/21.
//

import Foundation
import UIKit

enum Loginntype {
    case loggedIn
    case loggout
}


struct Userdefaultskey {
    
    static let authToken = "token"
    static let logintype   = "login"
    static let userId      = "userId"
    static let activityId  = "ActId"
    static let lat         = "lat"
    static let lng         = "lng"
    static let id          = "id"
    static let fcmToken    = "Fcmtoken"
    static let spaceId     = "spaceId"
    static let name        = "name"
    
}

extension UserDefaults {
    func loggedIntype(withLogin login: Loginntype) {
        let defaults = UserDefaults.standard
        if login == .loggedIn {
            defaults.set(true, forKey: Userdefaultskey.logintype)
        } else {
            defaults.set(false, forKey: Userdefaultskey.logintype)
        }
    }
    
    static var isLoggedin: Bool {
        return UserDefaults.standard.bool(forKey: Userdefaultskey.logintype)
    }
}
