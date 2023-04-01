//
//  ProgressBar.swift
//  magil
//
//  Created by Abservetech on 06/03/21.
//

import UIKit
import Lottie

final class ProgressBar {
    
    static let instance = ProgressBar()
 
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.hidesWhenStopped = true
     
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var lottieView: AnimationView = {
        let lottie = AnimationView(name: "8771-loading")
        lottie.frame.size = CGSize(width: 100, height: 90)
       lottie.backgroundColor = UIColor.clear
        lottie.layer.masksToBounds = false
        lottie.layer.shadowColor = UIColor.black.cgColor
        lottie.layer.shadowOpacity = 0.5
        lottie.layer.shadowOffset = .zero
        lottie.layer.shouldRasterize = true
        lottie.layer.rasterizationScale = UIScreen.main.scale
    
        lottie.layer.shadowRadius = 2
        return lottie
    }()
    private init() { }
    
    func showProgressBar(view: UIView) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    func showDriverProgress(view: UIView) {
        lottieView.center = view.center
        lottieView.loopMode = .loop
        view.addSubview(lottieView)
        lottieView.play()
    }
    func stopDriverProgress() {
        lottieView.removeFromSuperview()
        lottieView.pause()
    }
}
