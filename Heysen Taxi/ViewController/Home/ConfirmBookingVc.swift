//
//  ConfirmBookingVc.swift
//  MKSTaxi App
//
//  Created by develop on 29/03/22.
//

import UIKit
import MarqueeLabel

struct LatlngModel {
    var dropLat: String = String()
    var dropLng: String = String()
    var pickupLat: String = String()
    var pickupLng: String = String()
}

class ConfirmBookingVc: UIViewController {

    @IBOutlet weak var backBtn: UIImageView!
    
    @IBOutlet weak var carnameLbl: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var kmLbl: UILabel!
    @IBOutlet weak var promorightval: UILabel!
    @IBOutlet weak var promoleft: UILabel!
    //fare
    @IBOutlet weak var addbtn: UIButton!
    @IBOutlet weak var addAddressStkVw: UIStackView!
    @IBOutlet weak var fareBaseLbl: UILabel!
    @IBOutlet weak var fareAllowlbl: UILabel!
    @IBOutlet weak var fareTotLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var promoTRf: UITextField!
    
    @IBOutlet weak var confirmBookingBtn: UIButton!
    @IBOutlet weak var pickupAddLbl: UILabel!
    @IBOutlet weak var phn2Lbl: UILabel!
    @IBOutlet weak var dropAddLbl: UILabel!
    @IBOutlet weak var phnLbl: UILabel!
    @IBOutlet weak var changeVw: UIStackView!
    @IBOutlet weak var hideVw: UIView!
    
    //MARK: -- PROPERTIES
    var homepageVm = HomePageVm()
    var trip_type: RateType = .oneway
    var pickupId = Int()
    var dropId = Int()
    var vehicleId = Int()
    var pickdatetime = String()
    var dropdateTime = String()
    var pickupfullAdd = String()
    var dropfullAdd = String()
    var pick = String()
    var drop = String()
    var farearray = FareListModel()
    var kms = String()
    var profileVm = ProfileVm()
    var profileModel = ProfileModel()
    var latlngmodel = LatlngModel()
    
    var ourDate = String()
    var ourTime = String()
    
    var drpDate = String()
    var drpTime = String()
    var pickupnew = String()
    var dropnew = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datelbl.text = "on " + pickdatetime
        [promoleft, promorightval].forEach { vw in
            vw?.isHidden = true
        }
        addressLb.text =  pick.capitalized + "   " + "TO" + "   " + drop.capitalized
        carnameLbl.text = farearray.vehiclename
        promoTRf.addTarget(self, action: #selector(textfieldDidchange(_textfield:)), for: .editingChanged)
        
            
      
        if trip_type == .oneway {
            let rate = farearray.oneway_price.components(separatedBy: ".")
            let base = farearray.base_oneway_fare.components(separatedBy: ".")
            let allow = farearray.driver_oneway_fare.components(separatedBy: ".")
            let total = farearray.oneway_price.components(separatedBy: ".")
            kmLbl.text   = "Approx " + kms + "(oneway trip)"
            rateLbl.text = "Rs." + rate[0]
            fareBaseLbl.text = "Rs." + base[0]
            fareAllowlbl.text = "Rs." + allow[0]
            fareTotLbl.text   = "Rs." + total[0]
        } else {
            kmLbl.text   = "Approx " + kms + "(round trip)"
            let rate = farearray.round_price.components(separatedBy: ".")
            let base = farearray.base_round_fare.components(separatedBy: ".")
            let allow = farearray.driver_round_fare.components(separatedBy: ".")
            
            let total = farearray.round_price.components(separatedBy: ".")
            
            rateLbl.text = "Rs." + rate[0]
            fareBaseLbl.text = "Rs." + base[0]
            fareAllowlbl.text = "Rs." + allow[0]
            fareTotLbl.text   = "Rs." + total[0]
        }
        
        backBtn.addTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        addbtn.addTap { [unowned self] in
            let addAddVc = AddAddressVc.instantiate(fromStoryboard: .home)
            addAddVc.addressDelegate = self
            addAddVc.pickup = pick.capitalized
            addAddVc.drop  = drop.capitalized
            self.navigationController?.present(addAddVc, animated: true, completion: nil)
        }
        
        confirmBookingBtn.addTap { [unowned self] in
            
            if self.promoTRf.text!.isEmpty {
               
                confirmapi()
//                if self.hideVw.isHidden {
//                    Alerter.sharedInstense.showtoast(withMsg: "Please add your Address")
//                } else {
//
//                }
            } else {
                print("sadgasfdhgsad\(confirmBookingBtn.titleLabel?.text)")
                if confirmBookingBtn.titleLabel?.text == "Confirm Booking" {
                    confirmapi()
                } else {
                    self.coupon(withCoupon: self.promoTRf.text!)

                }
            }
        }
    }
    func confirmapi() {
        var type = ""
        if trip_type == .oneway {
            type = "oneway"
        } else {
            type = "round"
        }
        var confirmBooking = ConfirmBookingModel()
        confirmBooking.trip_type = type
        print("asdhfahgsfasdghafshgdasd\(pick)")
        print("ashdahsdfgasdf\(pickupnew)")
        print("sdfhgsdjhfgjsd\(pickupnew)")
        print("shgjasdghsad\(dropAddLbl.attributedText)")
        confirmBooking.pickup = pickupnew.isEmpty ? pick :  pickupnew
        confirmBooking.drop = dropnew.isEmpty ? drop : dropnew
        confirmBooking.pickup_address = pickupnew.isEmpty ? pick :  pickupnew
        confirmBooking.drop_address = dropnew.isEmpty ? drop : dropnew

        confirmBooking.pickup_date = pickdatetime
        confirmBooking.drop_date = dropdateTime
        confirmBooking.vehicle_type = vehicleId.description
        confirmBooking.optional_mobile = phn2Lbl.text!
        let name = UserDefaults.standard.string(forKey: Userdefaultskey.name) ?? ""
        confirmBooking.customer_name = name
        confirmBooking.pickup_address = pickupnew.isEmpty ? pick :  pickupfullAdd
        confirmBooking.drop_address = dropnew.isEmpty ? drop : dropfullAdd
        confirmBooking.drop_lang = latlngmodel.dropLng
        confirmBooking.drop_lat = latlngmodel.dropLat
        confirmBooking.pickup_lat = latlngmodel.pickupLat
        confirmBooking.pickup_lang = latlngmodel.pickupLng
        confirmBooking.promo_code = promoTRf.text!
        confirmBooking.function =  "booking"
         print("asdjgfashgdasd\(confirmBooking)")
        self.confirmBooking(withModel: confirmBooking)
    }
    @objc func textfieldDidchange(_textfield: UITextField) {
        if _textfield.text!.isEmpty {
            confirmBookingBtn.setTitle("Confirm Booking", for: .normal)
            [promoleft, promorightval].forEach { vw in
                vw?.isHidden = true
            }
            if trip_type == .oneway {
                let total = farearray.oneway_price.components(separatedBy: ".")
                fareTotLbl.text   = "Rs." + total[0]
            } else {
                let total = farearray.round_price.components(separatedBy: ".")
                fareTotLbl.text   = "Rs." + total[0]
            }
        } else {
            confirmBookingBtn.setTitle("Apply Coupon", for: .normal)
            
        }
    }
    
}

extension ConfirmBookingVc: AddressProtocol {
    func AddressFunc(withAddress: AddressModel) {
        addAddressStkVw.isHidden = true
        hideVw.isHidden = false
        
        let normalText = "\(withAddress.pickupAdd)"
        let boldText  = "pickupaddress : \n"
        let attributedString = NSMutableAttributedString(string: normalText)
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
        boldString.append(attributedString)
        pickupAddLbl.textColor = .darkGray
        pickupAddLbl.attributedText = boldString
        pickupAddLbl.numberOfLines = 0
        pickupnew = withAddress.pickupAdd
        dropnew = withAddress.dropAdd
        
        
        let normalText1 = "\(withAddress.dropAdd)"
        let boldText1  = "dropaddress : \n"
        let attributedString1 = NSMutableAttributedString(string: normalText1)
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        let boldString1 = NSMutableAttributedString(string: boldText1, attributes:attrs1)
        boldString1.append(attributedString1)
        dropAddLbl.textColor = .darkGray
        dropAddLbl.attributedText = boldString1
        dropAddLbl.numberOfLines = 0
        
        
//        pickupAddLbl.text = "pickupaddress : " + 	withAddress.pickupAdd
//        dropAddLbl.text   = "dropaddress : " + withAddress.dropAdd
        phn2Lbl.text      = withAddress.phone
        pickupfullAdd  = withAddress.pickupAdd
        dropfullAdd =  withAddress.dropAdd
        
        getProfile()
        changeVw.addTap {
            let addAddVc = AddAddressVc.instantiate(fromStoryboard: .home)
            addAddVc.addressDelegate = self
            addAddVc.addressModel = withAddress
            self.navigationController?.present(addAddVc, animated: true, completion: nil)
        }
    }
    
    func getProfile() {
        profileVm.getProfile()
        ProgressBar.instance.showDriverProgress(view: view)
        profileVm.successHandler = { (data) in
            ProgressBar.instance.stopDriverProgress()
            print("Sucess Response::\(data.profileModel)")
            Alerter.sharedInstense.showtoast(withMsg: "sucess")
            self.profileModel = data.profileModel
            self.nameLbl.text = self.profileModel.name
            self.phnLbl.text = self.profileModel.mobile
        }
        profileVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
            Alerter.sharedInstense.showtoast(withMsg: error)
        }
    }
}
extension ConfirmBookingVc {
    func coupon(withCoupon coupon: String) {
        homepageVm.applycoupon(with: coupon)
        ProgressBar.instance.showDriverProgress(view: view)
        homepageVm.successHandler = { [self] (sucess) in
            ProgressBar.instance.stopDriverProgress()
            print("success:\(sucess)")
            confirmBookingBtn.setTitle("Confirm Booking", for: .normal)
            [promoleft, promorightval].forEach { vw in
                vw?.isHidden = false
            }
            
           
            print("asdhfashdasd\(sucess.PROMO.offer)")
            promorightval.text = "- \(sucess.PROMO.offer)"
            
            if trip_type == .oneway {
                let total = farearray.oneway_price.components(separatedBy: ".")
                
                let name = "Rs." + "\((Int(total[0]) ?? 0) - (Int(sucess.PROMO.offer) ?? 0))"
                fareTotLbl.text! =  name
                
            } else {
                let total = farearray.round_price.components(separatedBy: ".")
                let name = "Rs." + "\((Int(total[0]) ?? 0) - (Int(sucess.PROMO.offer) ?? 0))"
                fareTotLbl.text = name
            }
            
            
        }
        homepageVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
            print("PROMO ERROR ::\(error)")
            Alerter.sharedInstense.showtoast(withMsg: error)
        }
    }
}
extension ConfirmBookingVc {
    func confirmBooking(withModel: ConfirmBookingModel) {
        homepageVm.confirmBooking(with: withModel)
        ProgressBar.instance.showDriverProgress(view: view)
        homepageVm.successHandler =  { (result) in
            ProgressBar.instance.stopDriverProgress()
            print("SUCESS::\(result.message)")
            Alerter.sharedInstense.showtoast(withMsg: result.message)
            Switcher.SwitcherVc(type: .home)
        }
        homepageVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
            Alerter.sharedInstense.showtoast(withMsg: error)
            print("ERRORRRR:::\(error)")
        }

    }
    
}
