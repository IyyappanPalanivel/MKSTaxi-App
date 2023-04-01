//
//  FAQModel.swift
//  MKSTaxi App
//
//  Created by develop on 21/03/22.
//

import Foundation
import SwiftyJSON



struct FAQModel: SwiftJson {
    
    var id : Int = Int()
    var title : String   = String()
    var description   : String    = String()
    var isHidden :Bool = Bool()
    
    init() {}
    
    init(json: JSON) {
        id = json["id"].int ?? Int()
        title = json["title"].string ?? String()
        description   = json["description"].string ?? String()
    }
}




