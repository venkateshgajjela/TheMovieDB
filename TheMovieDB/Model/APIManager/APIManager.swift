//
//  APIManager.swift
//  TheMovieDB
//
//  Created by VENKSTESHKSTL on 07/04/21.
//

import Foundation
import SystemConfiguration
import UIKit
typealias AnyObjectany = (_ response : AnyObject, _ error : Error?, _ statusCode: HTTPURLResponse?) -> Void

//typealias CompletionHandlerArray = (_ response : NSArray?, _ error : Error?) -> Void
class APIManager {

    static let sharedInstance = APIManager()
    
    func apiSerciceCall(controller: UIViewController, url : String, params : NSDictionary, method: HttpMethod, handler : @escaping AnyObjectany) {
        let url = K_HOST_URL + url
        print("url : \(url)")
        print("params : \(params)")
        DispatchQueue.main.async {
            VCActivityIndicator.shared.showActivityIndicator(controller: controller)
        }
        if self.isConnectedToNetwork(){
        HttpClient.instance().makeAPICallAuthorization(url: url, params: params, method: method, success: { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                print("===================response================ = \(json)")
                handler(json,error,(response))
                DispatchQueue.main.async {
                    VCActivityIndicator.shared.hideActivityIndicator()
                }
            } catch let error as NSError {
                print(error)
                handler(AnyObject.self as AnyObject,error,(response))
                DispatchQueue.main.async {
                    VCActivityIndicator.shared.hideActivityIndicator()
                }
            }
        }, failure: { (data, response, error) in
            handler(AnyObject.self as AnyObject,error,(response))
            DispatchQueue.main.async {
                VCActivityIndicator.shared.hideActivityIndicator()
            }
        })
        }else{
            DispatchQueue.main.async {
                CustomeAlert.shared.showValidationAlert(target: controller, title: "", message: "Please check your network") {
                }
        }
    }
    }
    
   
    
    public func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)

            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    SCNetworkReachabilityCreateWithAddress(nil, $0)
                }
            }) else {
                return false
            }

            var flags: SCNetworkReachabilityFlags = []
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                return false
            }
            if flags.isEmpty {
                return false
            }

            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)

            return (isReachable && !needsConnection)
        }

}
    



