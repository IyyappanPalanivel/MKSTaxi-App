//
//  ConatctUsVc.swift
//  MKSTaxi App
//
//  Created by develop on 09/05/22.
//

import UIKit

import Contacts
import ContactsUI

class ConatctUsVc: UIViewController {

    @IBOutlet weak var chatwhatsupVw: UIView!
    @IBOutlet weak var emailVw: UIView!
    @IBOutlet weak var emalLbl: UILabel!
    
    @IBOutlet weak var noLbl: UILabel!
    @IBOutlet weak var mobzvw: UIView!
    
    @IBOutlet weak var backimg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backimg.addTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        noLbl.text = "+91 78 8004 8004"
        emalLbl.text = "heysenmks@gmail.com"
        mobzvw.addTap {
            self.contactFunc()
        }
        
        emailVw.addTap {
            self.emailFunc()
        }
        
        chatwhatsupVw.addTap {
            self.whatsapp()
        }
    }
}


extension ConatctUsVc: CNContactViewControllerDelegate {
    func contactFunc() {
        
        if let url = URL(string: "tel://\(7540058005)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
//        let newContact = CNMutableContact()
//        newContact.phoneNumbers.append(CNLabeledValue(label: "", value: CNPhoneNumber(stringValue: "7540058005")))
//        let contactVC = CNContactViewController(forUnknownContact: newContact)
//        contactVC.contactStore = CNContactStore()
//        contactVC.delegate = self
//        contactVC.allowsActions = false
//        let navigationController = UINavigationController(rootViewController: contactVC) //For presenting the vc you have to make it navigation controller otherwise it will not work, if you already have navigatiation controllerjust push it you dont have to make it a navigation controller
//        self.present(navigationController, animated: true, completion: nil)
//       // self.navigationController?.pushViewController(navigationController, animated: true)
    }
    
    func emailFunc() {
        let email = "heysenmks@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func whatsapp() {
       
           let urlWhats = "whatsapp://send?phone=+917880048004&abid=12354&text=Share your feedback with Heysen Taxi here"
           if  let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
               if let whatsappURL = NSURL(string: urlString) {
                   if  UIApplication.shared.canOpenURL(whatsappURL as URL ) {
                       UIApplication.shared.open(whatsappURL as URL)
                   }
               }
           }
//        let urlWhats = "whatsapp://send?phone=+917540058005&abid=12354&text=Share your feedback withMKSTaxi here"
//        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
//            if let whatsappURL = URL(string: urlString) {
//                if UIApplication.shared.canOpenURL(whatsappURL) {
//                    UIApplication.shared.openURL(whatsappURL)
//                } else {
//                    print("Install Whatsapp")
//                }
//            }
//        }
    }
}
