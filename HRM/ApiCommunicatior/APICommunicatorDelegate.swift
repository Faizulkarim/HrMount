//
//  APICommunicatorDelegate.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 13/4/17.
//  Copyright © 2017 Bitmascot. All rights reserved.
//

import Foundation

protocol APICommunicatorDelegate : class {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int)

}
