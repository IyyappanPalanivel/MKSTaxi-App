//
//  ProfileVc.swift
//  MKSTaxi App
//
//  Created by develop on 22/03/22.
//

import UIKit
import Kingfisher
import PopupDialog

class ProfileVc: UIViewController {
    @IBOutlet weak var profNameLbl: UILabel!
    @IBOutlet weak var profImg: UIImageView!
    @IBOutlet weak var editImg: UIButton!
    @IBOutlet weak var secondNameLbl: UILabel!
    
    @IBOutlet weak var deleteVw: UIView!
    @IBOutlet weak var logoutBtn: UIView!
    @IBOutlet weak var contactVw: UIView!
    @IBOutlet weak var faqVw: UIView!
    //MARK: CONSTRAINTS
    
    //MARK: -- PROPERTIES
    var profileVm = ProfileVm()
    var profileModel = ProfileModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
    }
    override func viewWillAppear(_ animated: Bool) {
        getProfile()
    }
    
}
extension ProfileVc {
    func getProfile() {
        deleteVw.layer.cornerRadius = 10
        profileVm.getProfile()
        ProgressBar.instance.showDriverProgress(view: view)
        profileVm.successHandler = { (data) in
            print("Sucess Response::\(data.profileModel)")
            ProgressBar.instance.stopDriverProgress()
            self.profileModel = data.profileModel
            self.setAction()
        }
        profileVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
        }
        
        editImg.addTap {
            let editrProfileVc = EditProfileVc.instantiate(fromStoryboard: .main)
            editrProfileVc.profileModel = self.profileModel
            self.tabBarController?.navigationController?.pushViewController(editrProfileVc, animated: true)
        }
        
        faqVw.addTap {
            let faqVc = FAQVc.instantiate(fromStoryboard: .home)
            self.tabBarController?.navigationController?.pushViewController(faqVc, animated: true)
        }
        
        contactVw.addTap {
            let contactus = ConatctUsVc.instantiate(fromStoryboard: .home)
            self.tabBarController?.navigationController?.pushViewController(contactus, animated: true)
        }
        
        logoutBtn.addTap {
            let popupDialgoue = PopupDialog(title: "Logout?", message: "Are you sure you want Logout")
            let buttonTwo = DefaultButton(title: "Logout", dismissOnTap: false) {
                UserDefaults.standard.set(false, forKey: Userdefaultskey.logintype)
                Switcher.SwitcherVc(type: .login)
            }

            let buttonThree = DefaultButton(title: "Cancel", height: 60) {
            }
            popupDialgoue.addButtons([buttonTwo, buttonThree])
            self.present(popupDialgoue, animated: true, completion: nil)

        }
        
        deleteVw.addTap {
            let popupDialgoue = PopupDialog(title: "Delete Account", message: "Are you sure you want Delete Account")
            let buttonTwo = DefaultButton(title: "Delete", dismissOnTap: false) {
                UserDefaults.standard.set(false, forKey: Userdefaultskey.logintype)
                self.deleteFunc()
            }

            let buttonThree = DefaultButton(title: "Cancel", height: 60) {
            }
            popupDialgoue.addButtons([buttonTwo, buttonThree])
            self.present(popupDialgoue, animated: true, completion: nil)
        }
    }
    
    func setAction() {
        print("Valuesss:::", profileModel.avatar)
        profImg.kf.setImage(with: URL(string: profileModel.avatar))
        profNameLbl.text = profileModel.name
        secondNameLbl.text = profileModel.mobile
    }
    
    func deleteFunc() {
        profileVm.deleteFunc()
        profileVm.successHandler = { (data) in
            Alerter.sharedInstense.showtoast(withMsg: data.message)
            Switcher.SwitcherVc(type: .login)
        }
        profileVm.errorHandler = { (data) in
            Alerter.sharedInstense.showtoast(withMsg: data)
        }
    }
}
