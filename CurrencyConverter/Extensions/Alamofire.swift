//
//  Alamofire.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Alamofire

// MARK: - Http logging
extension DataRequest {
    
    public func logHttp() -> Self {
        
        // Exit if method or url is empty
        guard let method = request?.httpMethod, let path = request?.url?.absoluteString else {
            return self
        }
        
        //Print Http request
        if let data = request?.httpBody, let body = String(data: data, encoding: .utf8){
            debugPrint("--> \(method) \(path): \"\(body)\"")
        }else{
            debugPrint("--> \(method) \(path) ")
        }
        
        //Print Http headers
        if let headerFields = request?.allHTTPHeaderFields{
            for header in headerFields {
                debugPrint(header.key, ": ", header.value)
            }
        }
        
        //Print http response
        return response { response in
            guard let code = response.response?.statusCode, let path = response.request?.url?.absoluteString else {
                return
            }
            
            if  let data = response.data, let body = String(data: data, encoding: .utf8) {
                debugPrint("<-- \(code) \(path): \"\(body)\"")
            }
        }
    }
    
}
