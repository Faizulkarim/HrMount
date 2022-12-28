//
//  APIHelpers.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 23/5/17.
//  Copyright © 2017 WebAlive. All rights reserved.
//

import Foundation
import Alamofire

class APIHelpers: NSObject {
    
    static func getAccessToken() -> String {
        
        let appData = UserDefaults.standard
        if let access_token = appData.object(forKey: Constants.ACCESS_TOKEN) as? String {
            return access_token
        }
        return ""
    }
    
    static func getAuthHeader() -> HTTPHeaders {
        print("------> " + getAccessToken())
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            Constants.HEADER_KEY: getAccessToken()
        ]
        return header
    }
}
