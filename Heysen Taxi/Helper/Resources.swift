//
//  HyraApp
//
//  Created by muthuraja on 24/04/21.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol SwiftJson {
    init(json: JSON)
}


struct CodeResources<T: SwiftJson> {
    var url: String?
    var httpMethod: HTTPMethod = .get
    var params : Parameters? = nil
    var images : [UIImage]? = nil
    var multipart : [[String: Any]]? = nil
}


extension CodeResources {
    init(url: String) {
        self.url = url
    }
}
