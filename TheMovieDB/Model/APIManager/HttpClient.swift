//
//  HttpClient.swift
//  TheMovieDB
//
//  Created by VENKSTESHKSTL on 07/04/21.
//

import Foundation
import Foundation
//HTTP Methods
enum HttpMethod : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}


class HttpClient: NSObject{
    
    //TODO: remove app transport security arbitary constant from info.plist file once we get API's
    var request : URLRequest?
    var session : URLSession?
    
    static func instance() ->  HttpClient{
        
        return HttpClient()
    }
//
//    func makeAPICall(url: String,params: NSDictionary?, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?, NSError?) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
//        request = URLRequest(url: URL(string: url)!)
//
//        print("======URL REQUEST======== %@",url)
//        if let params = params {
//
//            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
//            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request?.httpBody = jsonData//?.base64EncodedData()
//
//            //paramString.data(using: String.Encoding.utf8)
//        }
//        request?.httpMethod = method.rawValue
//
//        let configuration = URLSessionConfiguration.default
//
//        configuration.timeoutIntervalForRequest = 30
//        configuration.timeoutIntervalForResource = 30
//
//        session = URLSession(configuration: configuration)
//        //session?.configuration.timeoutIntervalForResource = 5
//        //session?.configuration.timeoutIntervalForRequest = 5
//
//        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
//
//            if let data = data {
//
//                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
//                    success(data , response , error as NSError?)
//                } else {
//                    failure(data , response as? HTTPURLResponse, error as NSError?)
//                }
//                guard let mime = response?.mimeType, mime == "application/json" else {
//                    print("Wrong MIME type!")
//                    return
//                }
//            }else {
//
//                failure(data , response as? HTTPURLResponse, error as NSError?)
//            }
//            if error != nil {
//                print("Client error!")
//                return
//            }
//            }.resume()
//    }
    
//    func makeAPICallGet(url: String, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?, NSError?) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
//        request = URLRequest(url: URL(string: url)!)
//
//        print("======URL REQUEST======== %@",url)
////        let params = ""
//
////        if let params = param {
////            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
////            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
////            request?.httpBody = jsonData//?.base64EncodedData()
////
////            //paramString.data(using: String.Encoding.utf8)
////        }
//        request?.httpMethod = method.rawValue
//
//        let configuration = URLSessionConfiguration.default
//
//        configuration.timeoutIntervalForRequest = 30
//        configuration.timeoutIntervalForResource = 30
//
//        session = URLSession(configuration: configuration)
//        //session?.configuration.timeoutIntervalForResource = 5
//        //session?.configuration.timeoutIntervalForRequest = 5
//
//        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
//
//            if let data = data {
//
//                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
//                    success(data , response , error as NSError?)
//                } else {
//                    failure(data , response as? HTTPURLResponse, error as NSError?)
//                }
//            }else {
//
//                failure(data , response as? HTTPURLResponse, error as NSError?)
//
//            }
//            if error != nil {
//                print("Client error!")
//                return
//            }
//            }.resume()
//    }
    
    
    func makeAPICallAuthorization(url: String,params: NSDictionary?, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError?)-> Void) {
        request = URLRequest(url: URL(string: url)!)
        
        print("======URL REQUEST======== %@",url)
        if let params = params {
            
            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                        let token = "Bearer Token"
                        let tokenType = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMmIzOWVkZGE2YjlhNzc0OTNhZmEzOWMwNDM4YzQ5MSIsInN1YiI6IjYwNmM1Mjk2OThmMWYxMDA0MDU0MTQ5NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.radlFE6mTJuNZGDKY5mJXpN0XF1kB8_5R0GdmZjOEPA"
                        request?.setValue("\(tokenType) \(token)", forHTTPHeaderField: "Authorization")
            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if method == HttpMethod.GET{
            }else{
                request?.httpBody = jsonData//?.base64EncodedData()
                // paramString.data(using: String.Encoding.utf8)
            }
        }
        request?.httpMethod = method.rawValue
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        session = URLSession(configuration: configuration)
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                if let response = response as? HTTPURLResponse, 100...500 ~= response.statusCode{
                    print("Status Code : \(response.statusCode)")
                }
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    success(data , response , error as NSError?)
                } else {
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                }
            }else{
                failure(data , response as? HTTPURLResponse, error as NSError?)
            }
            }.resume()
        
    }
    
}
