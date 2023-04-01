//
//  HomePageContentVc.swift
//  MKSTaxi App
//
//  Created by develop on 18/03/22.
//




import UIKit
import YYCalendar
import WWCalendarTimeSelector
import DatePickerDialog
import GoogleMaps
import GooglePlaces

enum RateType {
    case oneway
    case roundway
}

enum AddressType {
    case pickup
    case drop
}
enum ApiChecking {
    case connected
    case notconnect
}

class HomePageContentVc: UIViewController {
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var pickCorVw: UIView!
    @IBOutlet weak var dropCorVw: UIView!
    @IBOutlet weak var dateCornerVw: UIView!
    @IBOutlet weak var tripCornerVw: UIView!
    @IBOutlet weak var journyCorVw: UIView!
    @IBOutlet weak var searchCorVw: UITableView!
    
    @IBOutlet weak var onewayClickVw: UIView!
    @IBOutlet weak var onewayLbl: UILabel!
    @IBOutlet weak var onewayVw: UIView!
    
    @IBOutlet weak var roundClickVw: UIView!
    @IBOutlet weak var roundLbl: UILabel!
    @IBOutlet weak var roundVw: UIView!
    
    @IBOutlet weak var pickRoundVw: UIView!
    @IBOutlet weak var pickUPVw: UIView!
    @IBOutlet weak var pickupLbl: UILabel!
    @IBOutlet weak var jounrneyVw: UIView!
    @IBOutlet weak var jounrenyLbl: UILabel!
    @IBOutlet weak var durlbl: UILabel!
    
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var tripVw: UIView!
    @IBOutlet weak var tripLbl: UILabel!
    @IBOutlet weak var hideVw: UIStackView!
    @IBOutlet weak var pickupDateVw: UIView!
    
    @IBOutlet weak var pickupDateLbl: UILabel!
    
    @IBOutlet weak var dropDateVw: UIView!
    @IBOutlet weak var dropDatelbl: UILabel!
    
    @IBOutlet weak var dropRoundVw: UIView!
    @IBOutlet weak var dropVw: UIView!
    @IBOutlet weak var dropLbl: UILabel!
    
    @IBOutlet weak var homeTbl: UITableView!
    
    var homepageVm =  HomePageVm()
    var onewayroundArray = [FareListModel]()
    var rateType : RateType = .oneway
    var addressType : AddressType = .pickup
    var pickId = Int()
    var dropId = Int()
    var date   = String()
    var time   = String()
    var dDate = String()
    var dTime = String()
    var dropDate = String()
    var isSelected = Bool()
    let timePicker = UIDatePicker()
    var sendingDate = String()
    var dateandTime = String()
    var pickupDate = String()
    var apiChecking : ApiChecking = .notconnect
    var estimatModel = EstimationModel()
    var isselected = false
    var countrycode = String()
    var latlngModel = LatlngModel()
    
    var pickDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAction()
        onewayround()
    }
    
    func setAction() {
        let cCode = Locale.current.regionCode
        print("Code::::", cCode)
        countrycode = cCode as? String ?? "IN"
        dropRoundVw.layer.cornerRadius = dropRoundVw.frame.width / 2
        pickRoundVw.layer.cornerRadius = pickRoundVw.frame.width / 2
        
        onewayClickVw.addTap { [unowned self] in
            onewayVw.backgroundColor = UIColor.init(hexString: "#E36169")
            onewayLbl.textColor = UIColor.init(hexString: "#E36169")
            roundVw.backgroundColor = UIColor.black
            roundLbl.textColor = UIColor.black
            dropDateVw.isHidden = true
            rateType = .oneway
            estimatModel.trip_type   = "oneway"
            if apiChecking == .notconnect {
                homeTbl.reloadData()
            } else {
                self.estimamtionDetails(estimate: estimatModel)
            }
            
        }
        
        [pickCorVw, dropCorVw, dateCornerVw, tripCornerVw, journyCorVw, searchCorVw].forEach { (viewss) in
            viewss?.cornerRadius(withradius: 8, withBackgroundColor: .clear, widthjBorderWidth: 0)
        }
        
        roundClickVw.addTap { [unowned self] in
            onewayVw.backgroundColor = UIColor.black
            onewayLbl.textColor = UIColor.black
            roundVw.backgroundColor = UIColor.init(hexString: "#E36169")
            roundLbl.textColor = UIColor.init(hexString: "#E36169")
            dropDateVw.isHidden = false
            rateType = .roundway
            estimatModel.trip_type   = "round"
            if apiChecking == .notconnect {
                homeTbl.reloadData()
            } else {
                if dropDatelbl.text == "Drop Date & Time" {
                } else {
                    self.estimamtionDetails(estimate: estimatModel)
                }
            }
        }
        
        pickUPVw.addTap {
            self.addressType = .pickup
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            let filter = GMSAutocompleteFilter()
            filter.type = .establishment
            filter.country = self.countrycode
            autocompleteController.autocompleteFilter = filter
            self.present(autocompleteController, animated: true, completion: nil)
        }
        
        
        dropVw.addTap {
            self.addressType = .drop
            
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            let filter = GMSAutocompleteFilter()
            filter.type = .establishment
            filter.country = self.countrycode
            autocompleteController.autocompleteFilter = filter
            self.present(autocompleteController, animated: true, completion: nil)
        }
        
        pickupDateVw.addTap {
            self.dropDatelbl.text = "Drop Date & Time"
            if self.validation() {
                DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel",  datePickerMode: .date) { date in
                    print("my date:::", date)
                    self.pickDate = date ?? Date()
                    if let dt = date {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        self.pickupDate = formatter.string(from: dt)
                        self.apiChecking = .connected
                        self.isselected = false
                        self.openTimePicker()
                    }
                }
            }
        }
        
        dropDateVw.addTap {
            if self.validation() {
                if !self.pickupDate.isEmpty {
                    DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) { date in
                        guard let nextDate = date else { return }
                        if self.pickDate < nextDate {
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                self.dropDate = formatter.string(from: dt)
                                self.apiChecking = .connected
                                self.isselected = true
                                self.openTimePicker1()
                            }
                        } else {
                            Alerter.sharedInstense.showtoast(withMsg: "Invalid Date")
                        }
                    }
                } else {
                    Alerter.sharedInstense.showtoast(withMsg: "Please select PickupDate First")
                }
            }
        }
    }
    
    func openTimePicker()  {
        DatePickerDialog().show("Select Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time) { [self] date in
            print("date:::", date)
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss"
                print("valuesss::::", formatter.string(from: dt))
                pickupDateLbl.text = pickupDate + " " + formatter.string(from: dt)
                if self.rateType == .oneway {
                    estimatModel.pickup_date = pickupDate + " " + formatter.string(from: dt)
                    estimatModel.function = "estimate"
                    estimatModel.pickup = pickId.description
                    estimatModel.drop  = dropId.description
                    estimatModel.trip_type   = "oneway"
                    estimatModel.pickup = pickupLbl.text!
                    estimatModel.drop = dropLbl.text!
                    estimatModel.pickAddress = pickupLbl.text!
                    estimatModel.dropAddress = dropLbl.text!
                    estimatModel.pickup_lat = latlngModel.pickupLat
                    estimatModel.pickup_lang = latlngModel.pickupLng
                    estimatModel.drop_lat = latlngModel.dropLat
                    estimatModel.drop_lang = latlngModel.dropLng
                    self.estimamtionDetails(estimate: estimatModel)
                }
            }
        }
    }
    
    func openTimePicker1()  {
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time) { [self] date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss"
                dropDatelbl.text = dropDate + " " + formatter.string(from: dt)
                estimatModel.pickup_date = pickupDateLbl.text!
                estimatModel.function = "estimate"
                estimatModel.pickup = pickId.description
                estimatModel.drop  = dropId.description
                estimatModel.drop_date = self.dropDate + " " + formatter.string(from: dt)
                print("estimate:::::", formatter.string(from: dt))
                estimatModel.trip_type   = "round"
                estimatModel.pickup = pickupLbl.text!
                estimatModel.drop = dropLbl.text!
                estimatModel.pickAddress = pickupLbl.text!
                estimatModel.dropAddress = dropLbl.text!
                estimatModel.pickup_lat = latlngModel.pickupLat
                estimatModel.pickup_lang = latlngModel.pickupLng
                estimatModel.drop_lat = latlngModel.dropLat
                estimatModel.drop_lang = latlngModel.dropLng
                self.estimamtionDetails(estimate: estimatModel)
            }
        }
    }
}

extension HomePageContentVc: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        if addressType == .pickup {
            pickupLbl.text = place.name ?? ""
            latlngModel.pickupLat = place.coordinate.latitude.description
            latlngModel.pickupLng = place.coordinate.longitude.description
            if !pickupLbl.text!.isEmpty && pickupDateLbl.text! != "Pickup Date & Time" && !dropLbl.text!.isEmpty {
                self.estimamtionDetails(estimate: estimatModel)
            }
        } else {
            dropLbl.text = place.name ?? ""
            latlngModel.dropLat = place.coordinate.latitude.description
            latlngModel.dropLng = place.coordinate.longitude.description
            print("valuesss:::",pickupLbl.text!, dropDatelbl.text!, dropLbl.text!)
            if !pickupLbl.text!.isEmpty && dropDatelbl.text! != "Drop Date & Time" && !dropLbl.text!.isEmpty {
                self.estimamtionDetails(estimate: estimatModel)
            }
        }
            
        print("pladhgvshdg", place.coordinate.latitude)
        self.dismiss(animated: true)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("sgfdhvcvs", error)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("cancel")
        dismiss(animated: true, completion: nil)
    }
}

extension HomePageContentVc: AddressDelegate {
    func addressDelegate(withAddress address: String, with id: Int, type: AddressType) {
        if type == .pickup {
            pickupLbl.text = address
            pickId = id
        } else {
            dropLbl.text = address
            dropId = id
        }
    }
    
    func validation() -> Bool {
        if pickupLbl.text == "Pickup Location" {
            Alerter.sharedInstense.showtoast(withMsg: "Please Select PickupAddress")
            return false
        } else if dropLbl.text! == "Drop Location" {
            Alerter.sharedInstense.showtoast(withMsg: "Please Select destination Address")
            return false
        }
        return true
    }
}
extension HomePageContentVc {
    func estimamtionDetails(estimate: EstimationModel) {
        homepageVm.estimationApi(with: estimate)
        ProgressBar.instance.showDriverProgress(view: view)
        homepageVm.successHandler =    { (datas) in
            ProgressBar.instance.stopDriverProgress()
            print("Sucess:\(datas.fareModel[0].driver_oneway_fare)")
            self.hideVw.isHidden = false
            self.isSelected = true
            self.onewayroundArray = datas.fareModel
            let fullNameArr = datas.fareModel[0].duratio.components(separatedBy: ":")
            if self.rateType == .oneway {
                self.durlbl.text = "Jounrney Duration"
                self.jounrenyLbl.text = fullNameArr[0] + " hours" + fullNameArr[1] + " mins"
            } else if self.rateType == .roundway {
                self.durlbl.text = "Jounrney Days"
                self.jounrenyLbl.text = datas.fareModel[0].noOfDays.description
            }
            
            let durations = datas.fareModel[0].trip_covers.components(separatedBy: ".")
            self.tripLbl.text = durations[0] + " Kms"
            print("valuesss:::", fullNameArr[0])
            self.homeTbl.reloadData()
        }
        homepageVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
            Alerter.sharedInstense.showtoast(withMsg: error)
        }
    }
}

extension HomePageContentVc {
    func onewayround() {
        homepageVm.Homepagedetails()
        ProgressBar.instance.showDriverProgress(view: view)
        homepageVm.successHandler = { (result) in
            ProgressBar.instance.stopDriverProgress()
            print("Response:: \(result.fareModel)")
            self.onewayroundArray = result.fareModel
            self.homeTbl.reloadData()
        }
        homepageVm.errorHandler =  { (error) in
            ProgressBar.instance.stopDriverProgress()
        }
    }
}

extension HomePageContentVc : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onewayroundArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageTvc", for: indexPath) as! HomePageTvc
        let onewayModel = onewayroundArray[indexPath.row]
        cell.carImg.image = UIImage(named: "taxi")
        cell.carnameLbl.text = onewayModel.vehiclename + "\n" + "(\(onewayModel.carnames))"
        if rateType == .oneway {
            cell.carImg.kf.setImage(with: URL(string: onewayModel.vehicleimage))
            cell.seatsAmountLbl.text = onewayModel.seats + " seats, Rs." + onewayModel.one_way_price + "/Km"
            let baseFare =  onewayModel.base_oneway_fare.components(separatedBy: ".")
            cell.basefareLbl.text = "Rs." + baseFare[0]
            let driver = onewayModel.driver_oneway_fare.components(separatedBy: ".")
            cell.driverLbl.text = "Rs." + driver[0]
            let total = onewayModel.oneway_price.components(separatedBy: ".")
            cell.totalLbl.text = "Rs." + total[0]
        } else {
            cell.carImg.kf.setImage(with: URL(string: onewayModel.vehicleimage))

            cell.seatsAmountLbl.text = onewayModel.seats + " seats, Rs." + onewayModel.round_trip_price + "/Km"
            let baseFare = onewayModel.base_round_fare.components(separatedBy: ".")
            cell.basefareLbl.text = "Rs." + baseFare[0]
            let driver = onewayModel.driver_round_fare.components(separatedBy: ".")
            cell.driverLbl.text   = "Rs." + driver[0]
            let total = onewayModel.round_price.components(separatedBy: ".")
            cell.totalLbl.text = "Rs." + total[0]
        }
        
        if isSelected {
            cell.hideVw.isHidden = false
        }
        cell.bookbtn.addTap {
            let detailVc = ConfirmBookingVc.instantiate(fromStoryboard: .home)
            detailVc.trip_type =  self.rateType
            detailVc.pickupId = self.pickId
            detailVc.dropId = self.dropId
            detailVc.pick = self.pickupLbl.text!
            detailVc.pickdatetime = self.pickupDateLbl.text!
            detailVc.dropdateTime = self.dropDatelbl.text!
            detailVc.drop = self.dropLbl.text!
            detailVc.ourDate = self.date
            detailVc.ourTime = self.time
            detailVc.vehicleId = self.onewayroundArray[indexPath.row].id
            detailVc.kms = self.tripLbl.text!
            detailVc.latlngmodel = self.latlngModel
            print("Modelsss::::", self.latlngModel)
            detailVc.farearray = self.onewayroundArray[indexPath.row]
            self.tabBarController?.navigationController?.pushViewController(detailVc, animated: true)
        }
        return cell
    }
}
