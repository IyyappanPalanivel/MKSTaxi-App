//
//  BaseModel.swift
//  MKSTaxi App
//
//  Created by develop on 20/03/22.
//

import Foundation
import SwiftyJSON

struct BaseModel: SwiftJson {
    
    var message : String = String()
    var success : Bool   = Bool()
    var check   : Int    = Int()
    var token   : String = String()
    var faqModel   : [FAQModel]   = [FAQModel]()
    var tarrifModel : [TarrifModel] = [TarrifModel]()
    var profileModel : ProfileModel = ProfileModel()
    var bookingModel : [BookingModel] = [BookingModel]()
    var fareModel    : [FareListModel] = [FareListModel]()
    var locationModel : [LocationModel] = [LocationModel]()
    var confirmbooking  : BookingModel = BookingModel()
    var PROMO  : BookingModel = BookingModel()
    var bannerModel : [BannerModel] = [BannerModel]()
    
    init() {}
    
    init(json: JSON) {
        self.PROMO = BookingModel(json: json["promoData"])
        message = json["message"].string ?? String()
        success = json["status_code"].bool ?? Bool()
        check   = json["status_code"].int ?? Int()
        token   = json["token"].string ?? String()
        let faqArray = json["faq"].array
        let faqJson = faqArray?.compactMap({ (data) -> FAQModel in
            return FAQModel.init(json: data)
        })
        self.faqModel = faqJson ?? [FAQModel]()
        self.profileModel = ProfileModel(json: json["user"])
        let tarrifArray = json["farelist"].array
        let tarrifJson = tarrifArray?.compactMap({ (data) -> TarrifModel in
            return TarrifModel.init(json: data)
        })
        self.tarrifModel = tarrifJson ?? [TarrifModel]()
        
        let bookingArray = json["bookings"].array
        let bookingJson = bookingArray?.compactMap({ (data) -> BookingModel in
            return BookingModel.init(json: data)
        })
        self.bookingModel = bookingJson ?? [BookingModel]()
        
        let fareArray = json["farelist"].array
        let fareJson = fareArray?.compactMap({ (data) -> FareListModel in
            return FareListModel.init(json: data)
        })
        self.fareModel = fareJson ?? [FareListModel]()
        
        let locArray = json["location"].array
        let locJson = locArray?.compactMap({ (data) -> LocationModel in
            return LocationModel.init(json: data)
        })
        self.locationModel = locJson ?? [LocationModel]()
        
        let bannerArray = json["banner"].array
        let bannerJson = bannerArray?.compactMap({ (data) -> BannerModel in
            return BannerModel.init(json: data)
        })
        self.bannerModel = bannerJson ?? [BannerModel]()
    }
}


struct BannerModel {
    var end_date : String = String()
    var id : Int = Int()
    var image_src : String = String()
    var start_date : String = String()
    var status : String = String()
    var title : String = String()
    init() {}
    init(json: JSON) {
        end_date = json["end_date"].string ?? String()
        id = json["id"].int ?? Int()
        image_src = json["image_src"].string ?? String()
        start_date = json["start_date"].string ?? String()
        status = json["status"].string ?? String()
        title = json["title"].string ?? String()
    }
}
