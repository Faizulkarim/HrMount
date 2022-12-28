//
//  Helpers.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 23/5/17.
//  Copyright © 2017 WebAlive. All rights reserved.
//

import Foundation
import SwiftyJSON

class Helpers: NSObject {
    
    
//    static func saveDictionary(_ data: UserModel, key: String) {
//        
//        let value = NSKeyedArchiver.archivedData(withRootObject: data) as Data
//        let appData = UserDefaults.standard
//        appData.set(value, forKey: key)
//        appData.set(data.access_token, forKey: Constants.ACCESS_TOKEN)
//        appData.synchronize()
//    }
//    
//    static func getDictionary(_ key: String) -> UserModel {
//        
//        var decodedValue = UserModel(user_id: 0, expires_in: 0, username: "", password: "", access_token: "", remember_me_enable: false)
//        let appData = UserDefaults.standard
//        if let result = appData.object(forKey: key) as? Data {
//            decodedValue = NSKeyedUnarchiver.unarchiveObject(with: result) as! UserModel
//            return decodedValue
//        }
//        return decodedValue
//    }
    
    static func setStringValueWithKey(_ data: String, key: String) {
        
        let appData = UserDefaults.standard
        appData.set(data, forKey: key)
        appData.synchronize()
    }
    
    static func setBoolValueWithKey(_ data: Bool, key: String) {
        
        let appData = UserDefaults.standard
        appData.set(data, forKey: key)
        appData.synchronize()
    }
    
    static func setIntValueWithKey(_ data: Int, key: String) {
        
        let appData = UserDefaults.standard
        appData.set(data, forKey: key)
        appData.synchronize()
    }
    
    static func getStringValueForKey(_ key: String) -> String {
        
        let appData = UserDefaults.standard
        if let value = appData.object(forKey: key) as? String {
            return value
        }
        return ""
    }
    
    static func getBoolValueForKey(_ key: String) -> Bool {
        
        let appData = UserDefaults.standard
        if let value = appData.object(forKey: key) as? Bool {
            return value
        }
        return false
    }
    
    static func getIntValueForKey(_ key: String) -> Int {
        
        let appData = UserDefaults.standard
        if let value = appData.object(forKey: key) as? Int {
            return value
        }
        return -1
    }
    
    static func removeValue(_ key: String) {
        
        let appData = UserDefaults.standard
        appData.removeObject(forKey: key)
        appData.synchronize()
    }
}








