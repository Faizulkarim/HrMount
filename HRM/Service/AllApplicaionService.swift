//
//  AllApplicaionService.swift
//  HRM
//
//  Created by Innovadeaus on 21/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import Foundation
import Alamofire
class AllApplicaionService : NSObject {
    var apiCommunicatorHelper: APICommunicator?
    
    var view: UIView?
    
    init(_ view: UIView, communicator: APICommunicator) {
        self.view = view
        self.apiCommunicatorHelper = communicator
    }
    
    func getAllApplication(type: String){
        let url = Urls.BASE_URL + Urls.LEAVE_LIST + type
        print(url)
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
    }
        
}
