//
//  FAQVc.swift
//  MKSTaxi App
//
//  Created by develop on 21/03/22.
//

import UIKit

class FAQVc: UIViewController {
    
    //MARK:: -- CONSTRINTS
    @IBOutlet weak var faqTvc: UITableView!
    
    @IBOutlet weak var backBtn: UIImageView!
    //MARK: -- PROPERTIES
    
    //jima ne ouutlet adukura table view name potuko
    let faqTableView = UITableView()
    var faqVm = FAQVm()
    var faqModel = [FAQModel]()
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faqData()
        backBtn.addTap {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension FAQVc {
    func faqData() {
        faqVm.AllDatas(with: "Faq")
        faqVm.successHandler = { (result) in
            self.faqModel = result.faqModel
            self.faqTvc.reloadData()
        }
        faqVm.errorHandler = { (error) in
        }
    }
}


extension FAQVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTvc") as! FAQTvc
        cell.topLbl.text = faqModel[indexPath.row].title
        cell.contentLbl.text = faqModel[indexPath.row].description
        if faqModel[indexPath.row].isHidden {
            cell.downImg.image = UIImage(named: "down")
            cell.hideVw.isHidden = false
        } else {
            cell.hideVw.isHidden = true
            cell.downImg.image = UIImage(named: "upload")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        faqModel[indexPath.row].isHidden = !faqModel[indexPath.row].isHidden
        faqTvc.reloadRows(at: [indexPath], with: .automatic)
    }
}
