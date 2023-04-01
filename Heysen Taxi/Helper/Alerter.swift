//
//  Alerter.swift
//  HyraApp
//
//  Created by muthuraja on 24/04/21.
//

import Foundation
import Toaster

class Alerter  {
    
    static let sharedInstense = Alerter()
    
    func showtoast(withMsg msg: String) {
        Toast(text: msg).show()
    }
}
