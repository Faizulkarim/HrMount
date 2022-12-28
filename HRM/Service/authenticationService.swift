//
//  authentication.swift
//  HRM
//
//  Created by Innovadeaus on 18/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import Foundation
import Alamofire

class authenticationService : NSObject {
    var apiCommunicatorHelper: APICommunicator?
    
    var view: UIView?
    
    init(_ view: UIView, communicator: APICommunicator) {
        self.view = view
        self.apiCommunicatorHelper = communicator
    }
    
    
    func doLogin(_ params: Parameters){
        let url = Urls.LOGIN_URL + Urls.LOGIN_URL
        apiCommunicatorHelper?.getDataByPOST(url, params: params, methodTag: MethodTags.FIRST, withHeader: false)
    }
}
