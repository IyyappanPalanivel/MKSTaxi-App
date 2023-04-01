//
//  SignUPVc.swift
//  MKSTaxi App
//
//  Created by develop on 16/03/22.
//

import UIKit
import iOSDropDown
import YYCalendar

class SignUPVc: UIViewController, UITextFieldDelegate {
    
    //MARK:: CONSTRAINTS
    
    @IBOutlet weak var backLbl: UILabel!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var genderTf: DropDown!
    @IBOutlet weak var nameVw: UIView!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var numTf: UITextField!
    @IBOutlet weak var numberVw: UIView!
    @IBOutlet weak var genderVw: UIView!
    @IBOutlet weak var dobVw: UIView!
    @IBOutlet weak var dobTf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var emailVw: UIView!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var signinVw: UIStackView!
    
    //MARK: - PROPERTIES
    
    let registerVm = RegisterVm()
    var datePicker = UIDatePicker()
    var genders = ["Male", "Female", "Others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAction()
        numTf.delegate = self
    }
    
}
extension SignUPVc {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 10
    }
}
extension SignUPVc {
    
    func addAction() {
        [nameVw, numberVw, genderVw, dobVw, emailVw].forEach { (views) in
            views?.roundCorner(view: views ?? UIView())
        }
        signupBtn.cornerRadius(withradius: 8, withBackgroundColor: .clear, widthjBorderWidth: 0)
        signinVw.addTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let charsLimit = 10
            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            return newLength <= charsLimit
        }
        
        [backImg, backLbl].forEach { (labels) in
            labels?.addTap {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        genderVw.addTap { [unowned self] in
            genderTf.optionArray = genders
            genderTf.didSelect{(selectedText , index ,id) in
            self.genderTf.text = selectedText
            }
            genderTf.showList()
        }
        
        signupBtn.addTap {
            if self.nameTf.text!.isEmpty {
                Alerter.sharedInstense.showtoast(withMsg: Constant.Signup.name)
            } else if  self.numTf.text!.isEmpty {
                Alerter.sharedInstense.showtoast(withMsg: Constant.Signup.phonNo)
            } else if self.emailtf.text!.isEmpty {
                Alerter.sharedInstense.showtoast(withMsg: Constant.Signup.email)
            } else if self.dobTf.text!.isEmpty {
                Alerter.sharedInstense.showtoast(withMsg: Constant.Signup.dob)
            } else {
                if self.genderTf.text == "Select Gender" {
                    let data = (self.nameTf.text!, self.emailtf.text!, self.numTf.text!, 0, "ios", self.dobTf.text!, "")
                    self.register(with: data)
                } else {
                    let data = (self.nameTf.text!, self.emailtf.text!, self.numTf.text!, 0, "ios", self.dobTf.text!, self.genderTf.text!.lowercased())
                    self.register(with: data)
                }
                
            }
        }
        dobTf.addTarget(self, action: #selector(showDatePicker), for: .allEvents)
    }
    
    @objc func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dobTf.inputAccessoryView = toolbar
        dobTf.inputView = datePicker
    }
    
    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }

    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dobTf.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

}
extension SignUPVc {
    
    typealias Credentials = (name: String, email: String, mobile: String, role_id: Int, device: String, dob: String, gender: String)
    
    func register(with credential: Credentials) {
        let registerDetails = (credential.name, credential.email, credential.mobile, credential.role_id, credential.device, credential.dob, credential.gender)
        registerVm.RegisterApi(with: registerDetails)
        ProgressBar.instance.showDriverProgress(view: view)
        registerVm.successHandler = { (result) in
            ProgressBar.instance.stopDriverProgress()
            let otpVc = OTPVc.instantiate(fromStoryboard: .main)
            otpVc.phone = self.numTf.text!
            self.navigationController?.present(otpVc, animated: true, completion: nil)
        }
        registerVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
            print("error:::", error)
            Alerter.sharedInstense.showtoast(withMsg: error)
        }
    }
}
