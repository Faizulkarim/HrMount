//
//  Devices.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 27/4/17.
//  Copyright © 2017 WebAlive. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    
    public class var isiPad: Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    public class var isiPadPro129: Bool {
        return isiPad && UIScreen.main.nativeBounds.size.height == 2732
    }
    
    public class var isiPadPro97: Bool {
        return isiPad && UIScreen.main.nativeBounds.size.height == 2048
    }
    
    public class var isiPadPro: Bool {
        return isiPad && (isiPadPro97 || isiPadPro129)
    }
}
