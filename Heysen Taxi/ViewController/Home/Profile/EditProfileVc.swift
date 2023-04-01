//
//  EditProfileVc.swift
//  MKSTaxi App
//
//  Created by develop on 23/03/22.
//

import UIKit
import iOSDropDown
import YYCalendar
import Kingfisher
import DatePickerDialog

class  EditProfileVc: UIViewController, UITextFieldDelegate {
    
    //MARK: -- CONSTRAINTS
    
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

    //MARK:-- PROPERTIES
    let editProfileVm = ProfileVm()
    var profileModel = ProfileModel()
    var genders = ["Male", "Female", "Others"]
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAction()
        getProfile()
        numTf.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let charsLimit = 10
        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        return newLength <= charsLimit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfile()
    }
    func getProfile() {
        editProfileVm.getProfile()
        editProfileVm.successHandler = { (data) in
            print("Sucess Response::\(data.profileModel)")
            self.profileModel = data.profileModel
            self.setAction()
        }
        editProfileVm.errorHandler = { (error) in
        }
    }
    
    func setAction() {
        
        [numberVw, genderVw, dobVw, nameVw, emailVw].forEach { (views) in
            views?.roundCorner(view: views ?? UIView())
        }
        
        [backLbl, backImg].forEach { (back) in
            back?.addTap {
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
        
        dobVw.addTap {
            DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date)  { date in
                if let dt = date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.dobTf.text = formatter.string(from: dt)
                }
            }
        }
        
        nameTf.text = profileModel.name
        numTf.text  = profileModel.mobile
        
        emailtf.text  = profileModel.email
        genderTf.text = profileModel.gender
        dobTf.text  = profileModel.dob
        print("GENDERR :\(genderTf.text!)")
        signupBtn.addTap { [self] in
            let userDetail = (nameTf.text!, emailtf.text!, numTf.text!, dobTf.text!, genderTf.text!.lowercased())
            EditProfile(with: userDetail)
            
        }
    }
}

extension EditProfileVc {
    typealias Credentials = (name: String, email: String, mobile: String, dob: String, gender: String)
    
    func EditProfile(with credential: Credentials) {
        let profileDetails = (credential.name, credential.email, credential.mobile, credential.dob, credential.gender)
        ProgressBar.instance.showDriverProgress(view: view)
        editProfileVm.updateProfile(with: profileDetails)
        editProfileVm.successHandler = { (result) in
            ProgressBar.instance.stopDriverProgress()
            print("Result", result.message)
            Alerter.sharedInstense.showtoast(withMsg: "Updated successfully")
            self.navigationController?.popViewController(animated: true)
        }
        editProfileVm.errorHandler = { (error) in
            Alerter.sharedInstense.showtoast(withMsg: error)
            ProgressBar.instance.stopDriverProgress()
        }
        
    }
    
}
