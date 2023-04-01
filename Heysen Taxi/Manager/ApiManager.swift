//
//  ApiManager.swift
//  HyraApp
//
//  Created by muthuraja on 24/04/21.
//

import Foundation

import SwiftyJSON
import Alamofire

class ApiMager: NSObject {
    
    static let share = ApiMager()
    static let accessHeader = "Authorization"
    static let contenttype  = "Content-Type"
    
    public func Apireqauest<T>(withResources resources: CodeResources<T>, completionHandler: @escaping (Swift.Result<T, ApiclientError>) -> Void) {
        
        if NetworkReachabilityManager()!.isReachable {
            var httpheader : HTTPHeaders = [:]
            let authtoken = UserDefaults.standard.string(forKey: Userdefaultskey.authToken) ?? ""
            let value = UserDefaults.standard.string(forKey: Userdefaultskey.logintype) ?? ""
            
            print("LOGIN TYPE:::\(value)")
            if authtoken.isEmpty {
                httpheader = [ApiMager.accessHeader: authtoken]
            } else {
                httpheader = [ApiMager.accessHeader: "Bearer " + authtoken]
                print("TOKENNNNN: \(authtoken)")
            }
            let requestUrl = URlNetwork.baseUrl + resources.url!
         
            print("Url::::", requestUrl)
            Alamofire.request(requestUrl, method: resources.httpMethod, parameters: resources.params, encoding: JSONEncoding.default, headers: httpheader).responseJSON { (responseData) in
                switch responseData.result {
                case .success(let value):
                    let status = responseData.response?.statusCode
                    print("Status Code:::", status)
                    if status == 200 {
                        let modelobj = T.init(json: JSON(value))
                        completionHandler(Swift.Result.success(modelobj))
                        print("RESPONSE DATA::", value)
                    } else {
                        let modelObj = ErrorModel.init(json: JSON(value))
                        print("Eerrorrr", modelObj)
                        completionHandler(.failure(.custom(modelObj)))
                    }
                    
                case .failure(let error):
                    let modelObj = ErrorModel.init(json: JSON(error))
                    completionHandler(.failure(.custom(modelObj)))
                }
            }
            
        } else {
            Alerter.sharedInstense.showtoast(withMsg: Constant.MainError.internetError)
        }
    }
    
    public func MultiPart<T>(withresources resources: CodeResources<T>, FormData: [[String: Any]], completionHandler: @escaping (Swift.Result<T, ApiclientError>) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            var httpheader : HTTPHeaders = [:]
            let authtoken = UserDefaults.standard.string(forKey: Userdefaultskey.authToken) ?? ""
            if authtoken.isEmpty {
                httpheader = [ApiMager.accessHeader: authtoken]
            } else {
                httpheader = [ApiMager.accessHeader: "Bearer" + authtoken, ApiMager.contenttype: "multipart/form-data"]
            }
            let requestUrl = URlNetwork.baseUrl + resources.url!
            print("Urlllssss:::", requestUrl)
            Alamofire.upload(multipartFormData: { (mutipartData) in
                for formData in FormData {
                    for(key, value) in formData {
                        if let value = value as? Data {
                            print("Datas::::::::\(key)  and valuessss:::::\(value)")
                            mutipartData.append(value, withName: key)
                        } else if let image = value as? UIImage {
                            let quality = image.jpegData(compressionQuality: 0.8)!
                            print("Imavge_key:::::\(key) and value::::;\(quality)")
                            mutipartData.append(quality, withName: key, fileName: "some.jpg", mimeType: "image/jpeg")
                        }
                    }
                }
            }, usingThreshold: UInt64.init(), to: requestUrl, method: resources.httpMethod, headers: httpheader) { (data) in
                switch data {
                case .success(let upload, _, _):
                    upload.validate(statusCode: 200..<500)
                    upload.responseJSON { (response) in
                        print("Valuessss:::", response.result.isSuccess)
                        guard response.result.isSuccess, let value = response.result.value  else {
                            print("Error For server Side:::::", response.result.error?.localizedDescription)
                            return }
                        let success = JSON(value)
                        print("ResponseData:::::", success)
                        let modobj = T.init(json: JSON(value))
                        completionHandler(Swift.Result.success(modobj))
                    }
                case .failure(let error):
                    print("Error", error)
                    completionHandler(.failure(.decodingError))
                }
            }
        } else {
            Alerter.sharedInstense.showtoast(withMsg: Constant.MainError.internetError)
        }
    }
}
