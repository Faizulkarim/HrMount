//
//  APICommunicator.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 13/4/17.
//  Copyright © 2017 Bitmascot. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import NotificationCenter
import LSDialogViewController
class APICommunicator: NSObject {
    
    var view: UIView?
    var delegate: APICommunicatorDelegate?
    var sessionManager: Alamofire.SessionManager?
    
    init(view: UIView) {
        self.view = view       
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(30)
        configuration.timeoutIntervalForResource = TimeInterval(30)
        configuration.httpAdditionalHeaders?.updateValue("application/json", forKey: "Content-Type")
        configuration.httpAdditionalHeaders?.updateValue("application/json", forKey: "Accept")
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func getDataByPOST(_ url: String, params: Parameters, methodTag: Int, withHeader: Bool) {
        
        let text = "Please wait..."
        SwiftOverlays.showCenteredWaitOverlayWithText(self.view!, text: text)
        self.view?.isUserInteractionEnabled = false
        
        print(Reachability.isConnectedToNetwork())
        if Reachability.isConnectedToNetwork() == true {
            
            if !withHeader {
                self.sessionManager?.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
                    .validate(contentType: ["application/json"])
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            if let statusCode = response.response?.statusCode {
                                if statusCode == Constants.SUCCESS_STATUS_CODE || statusCode == Constants.CREATED_STATUS_CODE || statusCode == Constants.FAILED_STATUS_CODE || statusCode == Constants.ERROR_STATUS_CODE || statusCode == Constants.UNAUTHORIZE_AGENT && statusCode == Constants.OTHERS_ERROR_STATUS_CODE {
                                    if let responseObject = response.result.value {
                                        self.view?.isUserInteractionEnabled = true
                                        if let result = responseObject as? Dictionary<String, Any> {
                                            SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                            self.delegate?.taskCompletationHandler(methodTag, data: result, statusCode: statusCode)
                                        }
                                        else{
                                            SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                            CustomAlertView.customAlertShow("", msgBody: "No data found!!!", delegate: self)
                                        }
                                    }
                                    else{
                                        self.view?.isUserInteractionEnabled = true
                                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                    }
                                }
                            }
                        case .failure(let error):
                            self.view?.isUserInteractionEnabled = true
                            if error._code == NSURLErrorTimedOut {
                                SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                            }
                            else {
                                SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                            }
                        }
                }
            }
            else {
                self.sessionManager?.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: APIHelpers.getAuthHeader())
                    .validate()
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            if let statusCode = response.response?.statusCode {
                                if statusCode == Constants.SUCCESS_STATUS_CODE || statusCode == Constants.CREATED_STATUS_CODE || statusCode == Constants.FAILED_STATUS_CODE || statusCode == Constants.ERROR_STATUS_CODE || statusCode == Constants.UNAUTHORIZE_AGENT && statusCode == Constants.OTHERS_ERROR_STATUS_CODE {
                                    if let responseObject = response.result.value {
                                        self.view?.isUserInteractionEnabled = true
                                        if let result = responseObject as? Dictionary<String, Any> {
                                            SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                            self.delegate?.taskCompletationHandler(methodTag, data: result, statusCode: statusCode)
                                        }
                                        else{
                                            SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                            CustomAlertView.customAlertShow("", msgBody: "No data found!!!", delegate: self)
                                        }
                                    }
                                    else{
                                        self.view?.isUserInteractionEnabled = true
                                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                    }
                                }
                            }
                        case .failure(let error):
                            self.view?.isUserInteractionEnabled = true
                            if error._code == NSURLErrorTimedOut {
                                SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                            }
                            else {
                                SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                            }
                        }
                }
            }
        }
        else if Reachability.isConnectedToNetwork() == false{
            
            SwiftOverlays.removeAllBlockingOverlays()
            self.view?.isUserInteractionEnabled = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "noInternet"), object: nil)
        }
    }
    
    
    func getDataByGET(_ url: String, methodTag: Int, withHeader: Bool) {
        
        let text = "Please wait..."
        SwiftOverlays.showCenteredWaitOverlayWithText(self.view!, text: text)
        self.view?.isUserInteractionEnabled = false
        
        if Reachability.isConnectedToNetwork() == true {
            
            if !withHeader {
                self.sessionManager?.request(url, method: .get).responseJSON { response in
                    switch response.result {
                    case .success:
                        if let statusCode = response.response?.statusCode {
                            if statusCode == Constants.SUCCESS_STATUS_CODE || statusCode == Constants.CREATED_STATUS_CODE || statusCode == Constants.FAILED_STATUS_CODE || statusCode == Constants.ERROR_STATUS_CODE && statusCode == Constants.OTHERS_ERROR_STATUS_CODE {
                                if let responseObject = response.result.value {
                                    self.view?.isUserInteractionEnabled = true
                                    if let result = responseObject as? Dictionary<String, Any> {
                                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                        self.delegate?.taskCompletationHandler(methodTag, data: result, statusCode: statusCode)
                                    }
                                    else{
                                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                        CustomAlertView.customAlertShow("", msgBody: "No data found!!!", delegate: self)
                                    }
                                }
                                else{
                                    self.view?.isUserInteractionEnabled = true
                                    SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                }
                            }
                        }
                    case .failure(let error):
                        self.view?.isUserInteractionEnabled = true
                        if error._code == NSURLErrorTimedOut {
                            
                            SwiftOverlays.removeAllOverlaysFromView(self.view!)
                             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                        }
                        else {
                            
                            SwiftOverlays.removeAllOverlaysFromView(self.view!)
                             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                        }
                    }
                }
            }
            else {
                self.sessionManager?.request(url, method: .get, headers: APIHelpers.getAuthHeader()).responseJSON { response in
                    switch response.result {
                    case .success:
                        if let statusCode = response.response?.statusCode {
                            if statusCode == Constants.SUCCESS_STATUS_CODE || statusCode == Constants.CREATED_STATUS_CODE || statusCode == Constants.FAILED_STATUS_CODE ||  statusCode == Constants.UNAUTHORIZE_AGENT || statusCode == Constants.ERROR_STATUS_CODE && statusCode == Constants.OTHERS_ERROR_STATUS_CODE {
                                if let responseObject = response.result.value {
                                    self.view?.isUserInteractionEnabled = true
                                    if let result = responseObject as? Dictionary<String, Any> {
                                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                        self.delegate?.taskCompletationHandler(methodTag, data: result, statusCode: statusCode)
                                    }
                                    else{
                                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                        CustomAlertView.customAlertShow("", msgBody: "No data found!!!", delegate: self)
                                    }
                                }
                                else{
                                    self.view?.isUserInteractionEnabled = true
                                    SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                }
                            }
                        }
                    case .failure(let error):
                        self.view?.isUserInteractionEnabled = true
                        if error._code == NSURLErrorTimedOut {
                            
                            SwiftOverlays.removeAllOverlaysFromView(self.view!)
                             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                        }
                        else {
                            
                            SwiftOverlays.removeAllOverlaysFromView(self.view!)
                             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                        }
                    }
                }
            }
        }
        else{
            
            SwiftOverlays.removeAllBlockingOverlays()
            self.view?.isUserInteractionEnabled = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "noInternet"), object: nil)
        }
    }
    
    
    func uploadPhoto(_ url: String, imageData: Data? , params: Parameters, methodTag: Int, withHeader: Bool) {
        
        let headers: HTTPHeaders = [
            Constants.HEADER_KEY: APIHelpers.getAccessToken(),
            "Content-Type": "application/json",
            "content-type": "multipart/form-data"
        ]
        
        let image_name_key = "profile_image"
        let image_name = "ios_upload_image_" + String.random(length: 7)
        let image_with_extension = image_name + ".png"
        
        let text = "Please wait..."
        SwiftOverlays.showCenteredWaitOverlayWithText(self.view!, text: text)
        self.view?.isUserInteractionEnabled = false
        
        if Reachability.isConnectedToNetwork() == true {
            
            self.sessionManager?.upload(
                multipartFormData: { multipartFormData in
                    for (key, value) in params {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    if let data = imageData {
                        multipartFormData.append(data, withName: image_name_key, fileName: image_with_extension, mimeType: "image/png")
                    }
                    
            }, to: url, method: .post, headers: headers) { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let statusCode = response.response?.statusCode {
                            if statusCode == Constants.SUCCESS_STATUS_CODE || statusCode == Constants.CREATED_STATUS_CODE || statusCode == Constants.FAILED_STATUS_CODE || statusCode == Constants.ERROR_STATUS_CODE && statusCode == Constants.OTHERS_ERROR_STATUS_CODE  {
                                if let responseObject = response.result.value {
                                    self.view?.isUserInteractionEnabled = true
                                    if let result = responseObject as? Dictionary<String, Any> {
                                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                        self.delegate?.taskCompletationHandler(methodTag, data: result, statusCode: statusCode)
                                    }
                                    else{
                                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                        CustomAlertView.customAlertShow("", msgBody: "Something went wrong!!!", delegate: self)
                                    }
                                }
                                else{
                                    self.view?.isUserInteractionEnabled = true
                                    SwiftOverlays.removeAllOverlaysFromView(self.view!)
                                }
                            }
                        }
                    }
                    
                case .failure(let error):
                    self.view?.isUserInteractionEnabled = true
                    if error._code == NSURLErrorTimedOut {
                        
                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                    }
                    else {
                        
                        SwiftOverlays.removeAllOverlaysFromView(self.view!)
                         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "serverError"), object: nil)
                    }
                }
            }
        }
        else{
            
            SwiftOverlays.removeAllBlockingOverlays()
            self.view?.isUserInteractionEnabled = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "noInternet"), object: nil)
        }
    }
    
    func getDataFromGoogleAPI(_ url: String, methodTag: Int, withHeader: Bool) {
    
        self.view?.isUserInteractionEnabled = true
        if Reachability.isConnectedToNetwork() == true {
            
            if !withHeader {
                self.sessionManager?.request(url, method: .get).responseJSON { response in
                    switch response.result {
                    case .success:
                        if let statusCode = response.response?.statusCode {
                            if statusCode == Constants.SUCCESS_STATUS_CODE || statusCode == Constants.CREATED_STATUS_CODE || statusCode == Constants.FAILED_STATUS_CODE || statusCode == Constants.ERROR_STATUS_CODE && statusCode == Constants.OTHERS_ERROR_STATUS_CODE {
                                if let responseObject = response.result.value {
                                    self.view?.isUserInteractionEnabled = true
                                    if let result = responseObject as? Dictionary<String, Any> {
                                        self.delegate?.taskCompletationHandler(methodTag, data: result, statusCode: statusCode)
                                    }
                                }
                                else{
                                    self.view?.isUserInteractionEnabled = true
                                }
                            }
                        }
                    case .failure(let error):
                        self.view?.isUserInteractionEnabled = true
                        if error._code == NSURLErrorTimedOut {
                            
                        }
                        else {
                            
                        }
                    }
                }
            }
            else {
                self.sessionManager?.request(url, method: .get, headers: APIHelpers.getAuthHeader()).responseJSON { response in
                    switch response.result {
                    case .success:
                        if let statusCode = response.response?.statusCode {
                            if statusCode == Constants.SUCCESS_STATUS_CODE || statusCode == Constants.CREATED_STATUS_CODE || statusCode == Constants.FAILED_STATUS_CODE ||  statusCode == Constants.UNAUTHORIZE_AGENT || statusCode == Constants.ERROR_STATUS_CODE && statusCode == Constants.OTHERS_ERROR_STATUS_CODE {
                                if let responseObject = response.result.value {
                                    self.view?.isUserInteractionEnabled = true
                                    if let result = responseObject as? Dictionary<String, Any> {
                                        self.delegate?.taskCompletationHandler(methodTag, data: result, statusCode: statusCode)
                                    }
                                }
                                else{
                                    self.view?.isUserInteractionEnabled = true
                                }
                            }
                        }
                    case .failure(let error):
                        self.view?.isUserInteractionEnabled = true
                        if error._code == NSURLErrorTimedOut {
                           
                        }
                        else {
                          
                        }
                    }
                }
            }
        }
        else{
            self.view?.isUserInteractionEnabled = true
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "noInternet"), object: nil)
        }
    }
}













