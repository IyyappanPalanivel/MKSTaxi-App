//
//  UIview+Ext.swift
//  MKSTaxi App
//
//  Created by develop on 23/04/22.
//

import Foundation
import UIKit

extension UIView {
    func roundCorner(view: UIView) {
        view.cornerRadius(withradius: 15, withBackgroundColor: .black, widthjBorderWidth: 0.2)
    }
}
