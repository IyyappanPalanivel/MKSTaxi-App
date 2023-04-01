//
//  HomePageVc.swift
//  MKSTaxi App
//
//  Created by develop on 18/03/22.
//

import UIKit
import CTSlidingUpPanel
import FSPagerView

class HomePageVc: UIViewController {
    
    @IBOutlet weak var pagerVw: FSPagerView! {
        didSet {
          self.pagerVw.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var contententView: UIView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var numberLb: UILabel!
    
    //MARK: -- PROPERTIES
    
    var profileVm = ProfileVm()
    var profileModel = ProfileModel()
    var homepageVm =  HomePageVm()
    var onewayroundArray = [FareListModel]()
    var bottomController:CTBottomSlideController?;
    var bannerModel = [BannerModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideupFunc()
        getProfile()
        onewayround()
    }
    
    func slideupFunc() {
        
        pagerVw.dataSource = self
        pagerVw.delegate = self
        pagerVw.automaticSlidingInterval = 3.0
        pagerVw.isInfinite = true
        contententView.addshadow(withShadow: .lightGray, withradius: 4)
        contententView.cornerRadius(withradius: 15, withBackgroundColor: .lightGray, widthjBorderWidth: 0)
        bottomController = CTBottomSlideController(parent: view, bottomView: contententView, tabController: self.tabBarController, navController: self.navigationController, visibleHeight: view.frame.width + 15)
        bottomController?.setAnchorPoint(anchor: 0.7)
    }
}
extension HomePageVc {
    func getProfile() {
        profileVm.getProfile()
        ProgressBar.instance.showDriverProgress(view: view)
        profileVm.successHandler = { (data) in
            ProgressBar.instance.stopDriverProgress()
            print("Sucess Response::\(data.profileModel)")
            self.profileModel = data.profileModel
            self.nameLb.text = "Hi," +  self.profileModel.name
            UserDefaults.standard.set(self.profileModel.name, forKey: Userdefaultskey.name)
            self.numberLb.text = self.profileModel.mobile
        }
        profileVm.errorHandler = { (error) in
        }
    }
    
    func onewayround() {
        homepageVm.Homepagedetails()
        ProgressBar.instance.showDriverProgress(view: view)
        homepageVm.successHandler = { (result) in
            ProgressBar.instance.stopDriverProgress()
            print("bannerModel \(result.bannerModel)")
            self.bannerModel = result.bannerModel
            self.pagerVw.reloadData()
        }
        homepageVm.errorHandler =  { (error) in
            print("Error::::", error)
            ProgressBar.instance.stopDriverProgress()
        }
    }

}


extension HomePageVc: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bannerModel.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: bannerModel[index].image_src))
        return cell
    }
}
