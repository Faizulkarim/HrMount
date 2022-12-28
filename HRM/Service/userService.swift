//
//  userService.swift
//  HRM
//
//  Created by Innovadeaus on 21/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
class UserService : NSObject {
    var apiCommunicatorHelper: APICommunicator?
    
    var view: UIView?
    
    init(_ view: UIView, communicator: APICommunicator) {
        self.view = view
        self.apiCommunicatorHelper = communicator
    }
    

    func getAllEmployeeList(){
        let url = Urls.BASE_URL + Urls.EMPLOYE_LIST
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
    }
    func getProfile() {
        let url = Urls.BASE_URL + Urls.USER_PROFILE_URL
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
    }
    
    func getNotice(){
        let url = Urls.BASE_URL + Urls.NOTICE
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
    }
    func uploadProfileImage(_ params: Parameters, imageData: Data) {
        let url = Urls.BASE_URL + Urls.UPLOAD_PROFILE_IMAGE_URL
        apiCommunicatorHelper?.uploadPhoto(url, imageData: imageData, params: params, methodTag: MethodTags.SECOND, withHeader: true)
       
    }
    func getSalary(){
        let url = Urls.BASE_URL + Urls.SALARY
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
    }
    func getClaim(){
        let url = Urls.BASE_URL +  Urls.CLAIM
        apiCommunicatorHelper?.getDataByGET(url, methodTag: MethodTags.FIRST, withHeader: true)
    }
    
}

