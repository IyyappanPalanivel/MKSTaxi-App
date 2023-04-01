//
//  AddressLocVc.swift
//  MKSTaxi App
//
//  Created by develop on 26/03/22.
//

import UIKit


protocol AddressDelegate {
    func addressDelegate(withAddress address: String, with id : Int, type: AddressType)
}

class AddressLocVc: UIViewController {

    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var addressTbl: UITableView!

    @IBOutlet weak var searchTf: UITextField!
    
    var faqVm = FAQVm()
    var locationModel = [LocationModel]()
    var delegate : AddressDelegate!
    var addressType : AddressType = .pickup
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressFunc()
        searchTf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        backBtn.addTap {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        values(with: textField)
    }
    func values(with type: UITextField) {
        print("hfhgfhgf\(type.text ?? "")")
        
        let filtered =  self.locationModel.filter { $0.name.contains(type.text ?? "") }
        print("asjdgkasd\(filtered)")
        if locationModel.isEmpty {
            addressFunc()
        } else {
           print("asdahsdfjsad")
        }
        if type.text?.count ?? 0 > 2  {
            filterContentForSearchText(searchText: type.text ?? "")
            print("sdfsdfghjsd\(locationModel.count)")
            self.addressTbl.reloadData()
           
            
        } else {
            addressFunc()
            print("usasgdhasdg")
        }
        

        
//        if filtered.isEmpty {
//            addressFunc()
//        } else {
//            self.locationModel = filtered
//            self.addressTbl.reloadData()
//        }
//
    }
    func filterContentForSearchText(searchText: String) {
        locationModel = locationModel.filter { item in
            return item.name.lowercased().contains(searchText.lowercased())
        }
    }

}


extension AddressLocVc {
    func addressFunc() {
        faqVm.AllDatas(with: "Location")
        ProgressBar.instance.showDriverProgress(view: view)
        faqVm.successHandler = { (result) in
            ProgressBar.instance.stopDriverProgress()
            self.locationModel = result.locationModel
            print("asdsadasd\(self.locationModel.count)")
            self.addressTbl.reloadData()
        }
        faqVm.errorHandler = { (error) in
            ProgressBar.instance.stopDriverProgress()
        }
    }
}



extension AddressLocVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressLocTvc", for: indexPath) as! AddressLocTvc
        cell.addresssLbl.text = locationModel[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("AddressType:::::", addressType)
        delegate.addressDelegate(withAddress: locationModel[indexPath.row].name, with: locationModel[indexPath.row].id, type: addressType)
        self.navigationController?.popViewController(animated: true)
    }
}
