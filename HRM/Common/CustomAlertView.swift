//
//  CustomAlertView.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 13/4/17.
//  Copyright © 2017 Bitmascot. All rights reserved.
//

import Foundation
import UIKit

open class CustomAlertView {
    
    static func customAlertShow(_ msgtitle: String, msgBody: String, delegate: AnyObject?) {
        
        let alert: UIAlertView = UIAlertView()
        alert.title = msgtitle as String
        alert.message = msgBody as String
        alert.delegate = delegate
        alert.addButton(withTitle: "OK")
        alert.show()
    }
}




