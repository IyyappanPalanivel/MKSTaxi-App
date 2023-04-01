//
//  UIViecontrollers+Ext.swift
//  HyraApp
//
//  Created by muthuraja on 21/03/21.
//

import Foundation
import UIKit

//public extension UIViewController {
//    func setStatusBar(color: UIColor) {
//        let tag = 12321
//        if let taggedView = self.view.viewWithTag(tag){
//            taggedView.removeFromSuperview()
//        }
//        let overView = UIView()
//        overView.frame = UIApplication.shared.statusBarFrame
//        overView.backgroundColor = color
//        overView.tag = tag
//        self.view.addSubview(overView)
//    }
//}

extension UIViewController {
    
    class var identifier: String {
        return "\(self)"
    }
    
    static func instantiate(fromStoryboard storyboard: AppStoryboard) -> Self {
        return storyboard.ViewController(vc: self)
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIView {
    func addTap(action: @escaping()  -> Void) {
        let tap = mytaprec(target: self, action: #selector(handletap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func handletap(_ sender: mytaprec) {
        sender.action!()
    }
    
    class mytaprec: UITapGestureRecognizer {
        var action: (() -> Void)? = nil
    }
    
    func cornerRadius(withradius radius: CGFloat, withBackgroundColor Backcolor: UIColor, widthjBorderWidth width: CGFloat = 0.05) {
        layer.borderWidth = width
        layer.cornerRadius  = radius
    }
    
    func addshadow(withShadow color: UIColor = .lightGray, withradius radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
