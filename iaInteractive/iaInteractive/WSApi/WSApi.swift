//
//  WSApi.swift
//  KokonutTemplate
//
//  Created by Aldo Bonilla on 22/08/16.
//  Copyright © 2016 Aldo Bonilla. All rights reserved.
//  Centraliza las llamadas web en una sola clase, si cambiamos el framework solo sera necesario hacer cambios en esta clase

import Foundation
import Alamofire

enum webMethod: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

class WSApi {
    
    static let sharedInstance = WSApi()
    
    var manager: NetworkReachabilityManager?
    
    func serviceWithURL(url: String, method: webMethod, parameters: BasicDictionary?, onCompletition:@escaping ((_ response: [BasicDictionary]?, _ error: NSError?) -> ())) {
        setupReachability()
        if manager?.networkReachabilityStatus == .notReachable {
            onCompletition(nil, NSError(domain: "WSApi", code: -1, userInfo: nil))
            return
        }
        Alamofire.request(url, method: Alamofire.HTTPMethod(rawValue: method.rawValue)!, parameters: parameters, encoding: JSONEncoding.default)
                 .validate()
                 .responseJSON(completionHandler: { response in
                    guard response.result.isSuccess else {
                        print("response failed for service: \(url)")
                        onCompletition(nil, NSError(domain: "WSApi", code: response.response?.statusCode ?? -1, userInfo: nil))
                        return
                    }
                    guard let json = response.result.value as? [BasicDictionary] else {
                        onCompletition(nil, NSError(domain: "WSApi", code: -2, userInfo: nil))
                        return
                    }
                    onCompletition(json, nil)
                
                 })
    }
    
    func downloadFileWithUrl(url: String, destinationName: String, onCompletition:@escaping ((_ success: Bool?) -> ())) {
        setupReachability()
        if manager?.networkReachabilityStatus == .notReachable {
            onCompletition(false)
            return
        }
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("\(destinationName).sqlite")
            return(fileURL, [.removePreviousFile])
        }
        
        Alamofire.download(url, method: .get, parameters: nil, encoding: JSONEncoding.default, to: destination).response { response in
            onCompletition(response.destinationURL != nil ? true : false)
        }
    }
    
    
    func setupReachability() {
        if manager != nil { return }
        manager = NetworkReachabilityManager(host: "www.apple.com")
        manager?.listener = { status in
            print("Network Status Changed: \(status)")
        }
        manager?.startListening()
    }
}
