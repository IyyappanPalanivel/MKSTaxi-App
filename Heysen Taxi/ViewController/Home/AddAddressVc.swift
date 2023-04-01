//
//  AddAddressVc.swift
//  MKSTaxi App
//
//  Created by develop on 04/04/22.
//

import UIKit

struct AddressModel {
    var pickupAdd : String = String()
    var dropAdd   : String = String()
    var phone     : String = String()
}

protocol AddressProtocol {
    func AddressFunc(withAddress: AddressModel)
}

class AddAddressVc: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var disVw: UIView!
    @IBOutlet weak var cornerVw: UIView!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var backBtn: UIImageView!
    
    @IBOutlet weak var fromTf: UITextField!
    @IBOutlet weak var toTf: UITextField!
   
    @IBOutlet weak var mobileniTf: UITextField!
   
    @IBOutlet weak var fromCorVw: UIView!
    @IBOutlet weak var tocornerView: UIView!
    @IBOutlet weak var phnCornerVw: UIView!
    
    var addressDelegate: AddressProtocol!
    var addressModel = AddressModel()
    
    var pickup = String()
    var drop = String()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !addressModel.pickupAdd.isEmpty {
            fromTf.text = addressModel.pickupAdd
            toTf.text   = addressModel.dropAdd
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let charsLimit = 10
        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        return newLength <= charsLimit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("valuesss:::", pickup, drop)
        fromTf.text = pickup
        toTf.text = drop
        mobileniTf.delegate = self
        backBtn.addTap {
            self.dismiss(animated: true, completion: nil)
        }
        disVw.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        [fromCorVw, tocornerView].forEach { (cornerVw) in
            cornerVw?.cornerRadius(withradius: 10, withBackgroundColor: .lightGray, widthjBorderWidth: 0.2)
        }
        
        mobileniTf.text = addressModel.phone
        
        phnCornerVw.cornerRadius(withradius: 20, withBackgroundColor: .lightGray, widthjBorderWidth: 0.2)
        
        saveBtn.addTap { [unowned self] in
            var addressModel = AddressModel()
            addressModel.pickupAdd = fromTf.text!
            addressModel.dropAdd   = toTf.text!
            addressModel.phone     = mobileniTf.text!
            addressDelegate.AddressFunc(withAddress: addressModel)
            self.dismiss(animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }
}
