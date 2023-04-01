//
//  AppStoryboard.swift
//  HyraApp
//
//  Created by muthuraja on 21/03/21.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    case main = "Main"
    case home = "Home"
    case menu = "Menu"
    case profile = "Profile"
    case host    = "Host"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func ViewController<T: UIViewController>(vc: T.Type) -> T {
        let storyboard = (vc as UIViewController.Type).identifier
        return instance.instantiateViewController(withIdentifier: storyboard) as! T
    }
}
