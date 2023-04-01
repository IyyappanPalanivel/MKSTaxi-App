//
//  Switcher.swift
//  HyraApp
//
//  Created by muthuraja on 01/05/21.
//

import Foundation
import UIKit

public enum AppSwitcher {
    case login
    case home
}

public class Switcher {
    public static func SwitcherVc(type: AppSwitcher) {
        var rootVc: UIViewController?
        switch type {
        case .login: 
            rootVc = LoginVc.instantiate(fromStoryboard: .main)
        case .home:
            rootVc = HomeTBc.instantiate(fromStoryboard: .home)
        }
        let navController = UINavigationController(rootViewController: rootVc!)
        navController.navigationBar.isHidden = true
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = navController
    }
}
