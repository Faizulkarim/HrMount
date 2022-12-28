//
//  AttendanceService.swift
//  HRM
//
//  Created by Innovadeaus on 20/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import Foundation
import Alamofire

class AttendanceService : NSObject {
    var apiCommunicatorHelper: APICommunicator?
    
    var view: UIView?
    
    init(_ view: UIView, communicator: APICommunicator) {
        self.view = view
        self.apiCommunicatorHelper = communicator
    }
    
    
    func doAttendance(_ params: Parameters){
        let url = Urls.BASE_URL + Urls.ATTENDACE
        apiCommunicatorHelper?.getDataByPOST(url, params: params, methodTag: MethodTags.FIRST, withHeader: true)
    }
    func doGetAttendance() {
        let url = Urls.BASE_URL + Urls.ATTEDDANCE_LIST
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
    }
    func doAttendanceReconciliation(_ params: Parameters){
        let url = Urls.BASE_URL + Urls.REQUEST_FOR_ATTENDENCE_RECONCILIATION
        apiCommunicatorHelper?.getDataByPOST(url, params: params, methodTag: MethodTags.FIRST, withHeader: true)
    }
    func getReconciliationList(){
        let url = Urls.BASE_URL + Urls.RECONCILIATION_LIST
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
        
    }
    func getHolidayList(){
        let url = Urls.BASE_URL + Urls.HOLIDAY_C
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
    }
}
