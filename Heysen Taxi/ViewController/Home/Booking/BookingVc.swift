//
//  BookingVc.swift
//  MKSTaxi App
//
//  Created by develop on 23/03/22.
//

import UIKit

class BookingVc: UIViewController {
    
    @IBOutlet weak var bookingTbl: UITableView!
    @IBOutlet weak var booklbl: UILabel!

   
    
    //MARK:-- CONSTRAINTS
    var bookingVm = BookingVm()
    var bookingArray = [BookingModel]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        bookingList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booklbl.isHidden = false
        bookingTbl.rowHeight = UITableView.automaticDimension
        bookingTbl.estimatedRowHeight = UITableView.automaticDimension

    }
    
}
extension BookingVc {
    func cancel(with id: String) {
        bookingVm.cancelbooking(with: id)
        ProgressBar.instance.showDriverProgress(view: view)
        bookingVm.successHandler = { [self] (datas) in
            print("CANCELLLL::\(datas)")
            bookingList()
        }
        bookingVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
        }
    }
   
    func bookingList() {
        bookingVm.getBookingDetails()
        ProgressBar.instance.showDriverProgress(view: view)
        bookingVm.successHandler = { [self] (datas) in
            ProgressBar.instance.stopDriverProgress()
            print("Response sdklfhjsdkfsd:: \(datas.bookingModel)")
            self.bookingArray = datas.bookingModel
            if bookingArray.isEmpty {
                booklbl.isHidden = false
                bookingTbl.isHidden = true
            } else {
                booklbl.isHidden = true
                bookingTbl.isHidden = false
            }
            bookingTbl.reloadData()
            
        }
        bookingVm.errorHandler = { (error) in
          // Alerter.sharedInstense.showtoast(withMsg: error)
            ProgressBar.instance.stopDriverProgress()
        }
    }
    
}
extension BookingVc : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTvc", for: indexPath) as! HistoryTvc
        cell.carnameLbl.text = bookingArray[indexPath.row].vehicle_name + "(#\(bookingArray[indexPath.row].booking_id))"
        
        let dateFormatter : DateFormatter = DateFormatter()
        //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm"

        let date1 = dateFormatter1.date(from: dateString)
        dateFormatter1.dateFormat = "yyyy-MM-dd h:mm:ss"
        let Date12 = dateFormatter1.string(from: date1  ?? Date())
        print("12 hour formatted Date:",Date12)
         
        let book = bookingArray[indexPath.row]
        print("sdfdsfsdfsdf\(book.pickup_date)")
       // let someDateTime = formatter.date(from: "2016/10/08 22:31")
        cell.priceLbl.text = "Rs. " + book.price

        if book.pickup_date.isEmpty {
            cell.dateTineLbl.isHidden = true
        } else {
            cell.dateTineLbl.isHidden = false
            cell.dateTineLbl.text! = book.pickup_date
        }
       
        cell.fromAddresslbl.text! = book.pickup_address
        cell.toAddressLbl.text! = book.drop_address
        cell.statusLbl.text    = book.order_status
       
        
        if book.drop_date == "" || book.drop_date == "<null>" {
            cell.bookTypeLbl.text = "(oneway Trip)"
        } else {
            cell.bookTypeLbl.text = "(Round Trip)"
        }
        print("sdfhgsdhjfgdsf\(book.isCancel)")
        print("sdfvsbndfvnsdf\(book.order_status)")
        cell.cancelBtn.layer.cornerRadius = 8
        cell.cancelBtn.addTap {
            self.cancel(with: book.id.description)
        }
        if book.is_cancel == 1  {
            if book.order_status == "Booked" {
                cell.cancelBtn.isHidden = false
                UIView.animate(withDuration: 5.5, animations: {
                    cell.cancelhgt.constant = 50
                })
            }
        } else {
            cell.cancelBtn.isHidden = true
            UIView.animate(withDuration: 5.5, animations: {
                cell.cancelhgt.constant = 1
            })
        }
        
//        if book.isCancel {
////            if book.order_status == "Cancelled by Customer" {
////                cell.cancelBtn.isHidden = false
////                UIView.animate(withDuration: 5.5, animations: {
////                    cell.cancelhgt.constant = 0
////                })
////            } else {
//
//    //        }
//
//        } else {
//            cell.cancelBtn.isHidden = true
//        }

        if book.driver_Details.name.isEmpty {
            cell.drivedetail.isHidden = true
            cell.drivelb.isHidden = true
          //  cell.new.isHidden = true
            UIView.animate(withDuration: 5.5, animations: {
                cell.hgt.constant = 10
            })
//            cell.cancelBtn.isHidden = false
//            UIView.animate(withDuration: 5.5, animations: {
//                cell.cancelhgt.constant = 0
//            })
        } else {
            UIView.animate(withDuration: 5.5, animations: {
                cell.hgt.constant = 128
            })
//            UIView.animate(withDuration: 5.5, animations: {
//                cell.cancelhgt.constant = 50
//            })
//            cell.cancelBtn.isHidden = false
            cell.drivedetail.isHidden = false
       //     cell.new.isHidden = false
            cell.drivelb.isHidden = false
            cell.nameLbl.text      = "Name :" + book.driver_Details.name
            print("asdgfasghasfd\(book.driver_vechicle.car_model_name)")
            if !book.driver_vechicle.car_model_name.isEmpty {
                cell.vechNameLbl.text  = "Vechicle Details :" + book.driver_vechicle.vehicle_name + " (\(book.driver_vechicle.car_model_name))"
                
            } else {
                cell.vechNameLbl.isHidden = true
//                cell.vechNameLbl.text  = "Vechicle Details :" + book.driver_Details.name + "(\(book.driver_Details.vehicle_model))"
            }
            cell.regNolbl.text     = "Registeration No :" + book.driver_vechicle.registration_no
            cell.mobilenoLbl.text  = "Mobile No :" + book.driver_Details.mobile
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
}
