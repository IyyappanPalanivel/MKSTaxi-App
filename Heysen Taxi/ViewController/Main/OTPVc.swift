//
//  OTPVc.swift
//  MKSTaxi App
//
//  Created by develop on 16/03/22.
//

import UIKit
import SVPinView

class OTPVc: UIViewController {
    
    

    //MARK:: -- CONSTRAINTS
    
    @IBOutlet weak var cornerVw: UIView!
    @IBOutlet weak var dismissVw: UIView!
    @IBOutlet weak var pinView: SVPinView!
    @IBOutlet weak var verfybtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var secondtimer: UILabel!
    
    //MARK: -- PROPERTIES
    var otp = String()
    var phone = String()
    var otpVm = OtpVm()
    var count = 10
    var loginVm = LoginVm()
    var timer1:Timer?
    var timeLeft = 7
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.text = "1 min"
        setupTimer()
        dismissVw.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        addAction()
        pinView.didFinishCallback = { [weak self] pin in
            print("The pin entered is \(pin)")
            self?.otp = pin
        }
        secondtimer.addTap {
            if self.secondtimer.text == "Resend OTP" {
                let datas = (self.phone, 0 , "ios")
                self.login(with: datas)
            }
        }
        
    }
    func setupTimer() {
        timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    @objc func onTimerFires() {
        timeLeft -= 1
        secondtimer.text = "\(timeLeft) sec"
        
        if timeLeft <= 0 {
            if timeLeft == 0 {
                if timer.text == "1 min" {
                    timeLeft = 60
                    timer.text = "0 min"
                }
                else {
                    timer.isHidden = true
                    secondtimer.text = "Resend OTP"
                    
                    timer1?.invalidate()
                    timer1 = nil
                }
                
            } else {
                
            }
        }
    }

    
}
extension OTPVc {
    
    typealias CredentialDA = (Mobile: String, role_id: Int, device: String)
    
    func login(with credential : CredentialDA) {
        let details = (credential.Mobile, credential.role_id, credential.device)
        ProgressBar.instance.showDriverProgress(view: view)
        loginVm.loginApi(with: details)
        loginVm.successHandler = { (result) in
            ProgressBar.instance.stopDriverProgress()
           
        }
        loginVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
            Alerter.sharedInstense.showtoast(withMsg: error)
        }
    }
}

extension OTPVc {
    
    typealias Credential = (Mobile: String, otp: String, device: String, mobile_token: String, role_id: Int)
    func otpApi(with credential : Credential) {
        
        let otpdetails = (credential.Mobile, credential.otp, credential.device, credential.mobile_token, credential.role_id)
        ProgressBar.instance.showDriverProgress(view: view)
        otpVm.OtpApi(with: otpdetails)
        otpVm.successHandler = { (result) in
            ProgressBar.instance.stopDriverProgress()
            print("Valuess::::", result.token)
            UserDefaults.standard.set(true, forKey: Userdefaultskey.logintype)
            UserDefaults.standard.set(result.token, forKey: Userdefaultskey.authToken)
            Switcher.SwitcherVc(type: .home)
        }
        otpVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
        }
    }
}
extension OTPVc {
    func addAction() {
        dismissVw.addTap {
            self.dismiss(animated: true, completion: nil)
        }
        verfybtn.addTap {
          
            if self.otp.isEmpty {
                Alerter.sharedInstense.showtoast(withMsg: Constant.Signup.otp)
            } else {
                let fcm_token = UserDefaults.standard.string(forKey: Userdefaultskey.fcmToken) ?? ""
                print("token::::", fcm_token)
                let data = (self.phone, self.otp, "ios", fcm_token, 0)
                self.otpApi(with: data)
            }
        }
    }
}
