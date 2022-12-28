//
//  CustomAlertPopup.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 13/4/17.
//  Copyright © 2017 Bitmascot. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

open class CustomAlertPopup {
    
    static func customPopupShow(_ msgtitle: String, msgBody: String, buttonTitle: String) -> PopupDialog {
        
        let popup = PopupDialog(title: msgtitle, message: msgBody)
        
        let buttonTwo = DefaultButton(title: buttonTitle) {
            
        }
        popup.addButtons([buttonTwo])
        
        return popup
    }
    
    static func customOkayPopup(_ msgtitle: String, msgBody: String) -> PopupDialog {
        
        let popup = PopupDialog(title: msgtitle, message: msgBody)
        let button = DefaultButton(title: "OK") {
            
        }
        popup.addButtons([button])
        return popup
    }
    
    static func customPopupForLogout(_ msgTitle: String, msgBody: String, delegate: AnyObject?) -> PopupDialog {
        
        let popup = PopupDialog(title: msgTitle, message: msgBody)
        let button = DefaultButton(title: "OK") {
            
        }
        popup.addButtons([button])
        return popup
    }
}
