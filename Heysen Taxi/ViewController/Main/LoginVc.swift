//
//  LoginVc.swift
//  MKSTaxi App
//
//  Created by develop on 16/03/22.
//

import UIKit

enum OtpType {
    case login
    case sign
}

class LoginVc: UIViewController, UITextFieldDelegate {
    
    //MARK:  CONSTRAINTS
    
    @IBOutlet weak var mobilenoCornerVw: UIView!
    @IBOutlet weak var mobNumTf: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupLbl: UIStackView!
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var secondtimer: UILabel!
    
    //MARK: PROPERTIES
    var loginVm = LoginVm()
    var otpType :OtpType = .login

    
    var timer1:Timer?
    var timeLeft = 7

    override func viewDidLoad() {
        super.viewDidLoad()

        addAction()
        mobNumTf.delegate = self
    }
    
       
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let charsLimit = 10
        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        return newLength <= charsLimit
    }
}

extension LoginVc {
    func addAction() {
        mobilenoCornerVw.roundCorner(view: mobilenoCornerVw)
        signupLbl.addTap {
            let signupVc = SignUPVc.instantiate(fromStoryboard: .main)
            self.navigationController?.pushViewController(signupVc, animated: true)
        }
        loginBtn.cornerRadius(withradius: 8, withBackgroundColor: .clear, widthjBorderWidth: 0)
        loginBtn.addTap {
            if self.mobNumTf.text!.isEmpty  {
                Alerter.sharedInstense.showtoast(withMsg: "Please Enter a Mobilenumber")
            } else {
                let datas = (self.mobNumTf.text!, 0 , "ios")
                self.login(with: datas)
            }
        }
    }
}
extension LoginVc {
    
    typealias Credential = (Mobile: String, role_id: Int, device: String)
    
    func login(with credential : Credential) {
        let details = (credential.Mobile, credential.role_id, credential.device)
        ProgressBar.instance.showDriverProgress(view: view)
        loginVm.loginApi(with: details)
        loginVm.successHandler = { (result) in
            ProgressBar.instance.stopDriverProgress()
            let otpVc = OTPVc.instantiate(fromStoryboard: .main)
            otpVc.phone = self.mobNumTf.text!
            self.navigationController?.present(otpVc, animated: true, completion: nil)
        }
        loginVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
            Alerter.sharedInstense.showtoast(withMsg: error)
        }
    }
}
