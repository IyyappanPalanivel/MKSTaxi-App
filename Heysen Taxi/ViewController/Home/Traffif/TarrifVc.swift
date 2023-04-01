//
//  TarrifVc.swift
//  MKSTaxi App
//
//  Created by develop on 22/03/22.
//

import UIKit


class TarrifVc: UIViewController {
    @IBOutlet weak var oneWayLbl: UILabel!
    @IBOutlet weak var onewayClickVw: UIView!
    @IBOutlet weak var onewayundelineVw: UIView!
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var roundLbl: UILabel!
    
    @IBOutlet weak var roundClickVw: UIView!
    @IBOutlet weak var roundunderLineVw: UIView!
    
    //MARK:  CONSTRAINTS
    
    // MARK: PROPERTIES
    var rateType : RateType = .oneway
    var alldatas = FAQVm()
    var tarrifArray = [TarrifModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AllData()
    }
}
extension TarrifVc {
    func AllData() {
        alldatas.AllDatas(with: "Farelist")
        ProgressBar.instance.showDriverProgress(view: view)
        alldatas.successHandler = { (result) in
            ProgressBar.instance.stopDriverProgress()
            self.tarrifArray = result.tarrifModel
            self.tableView.reloadData()
        }
        alldatas.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
        }
        
        onewayClickVw.addTap { [unowned self] in
            onewayundelineVw.backgroundColor = UIColor.init(hexString: "#E36169")
            oneWayLbl.textColor = UIColor.init(hexString: "#E36169")
            roundunderLineVw.backgroundColor = UIColor.black
            roundLbl.textColor = UIColor.black
            rateType = .oneway
            AllData()
        }
        
        roundClickVw.addTap { [unowned self] in
            onewayundelineVw.backgroundColor = UIColor.black
            oneWayLbl.textColor = UIColor.black
            roundunderLineVw.backgroundColor = UIColor.init(hexString: "#E36169")
            roundLbl.textColor = UIColor.init(hexString: "#E36169")
            rateType  = .roundway
            AllData()
        }
    }
}


extension TarrifVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarrifArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TerrifTvc", for: indexPath) as! TerrifTvc
        let details = tarrifArray[indexPath.row]
        cell.nameLbl.text! = details.vehiclename
        cell.seatsLbl.text! =  details.seats.description + " Seats"
        cell.desclbl.text! = details.carnames
        
        if rateType == .oneway {
            cell.amountLbl.text = "₹ " + details.one_way_price
        } else {
            cell.amountLbl.text = "₹ " + details.round_trip_price
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
