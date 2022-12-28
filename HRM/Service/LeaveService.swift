//
//  LeaveService.swift
//  HRM
//
//  Created by Innovadeaus on 20/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//


import Foundation
import Alamofire

class LeaveService : NSObject {
    var apiCommunicatorHelper: APICommunicator?
    
    var view: UIView?
    
    init(_ view: UIView, communicator: APICommunicator) {
        self.view = view
        self.apiCommunicatorHelper = communicator
    }
    
    func doRequestForLeave (_ params: Parameters){
        let url = Urls.BASE_URL + Urls.REQUEST_FOR_LEAVE
        apiCommunicatorHelper?.getDataByPOST(url, params: params, methodTag: MethodTags.SECOND, withHeader: true)
        
    }
    func doGetleaveType(){
        let url = Urls.BASE_URL + Urls.LEAVE_TYPE
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
    }

}

