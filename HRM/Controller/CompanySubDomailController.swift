//
//  CompanySubDomailController.swift
//  HRM
//
//  Created by Innovadeaus on 20/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON

class CompanySubDomailController: UIViewController {

    @IBOutlet weak var companySubDomainText: UITextField!
    var authenticationService: AuthenticationService?
    var apiCommunicatorHelper: APICommunicator?
    override func viewDidLoad() {
        super.viewDidLoad()

        initApiCommunicatorHelper()
        // Do any additional setup after loading the view.
    }
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        authenticationService = AuthenticationService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    
    func navigateToLogin() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "login") as? LoginController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    @IBAction func submit(_ sender: Any) {
        doCompanyCheck()
    }
    
    func doCompanyCheck(){
        let companySubName = companySubDomainText.text!
        
        let params = [
            "company_code": companySubName
        
        ]
        authenticationService?.doCheckLogin(params)
    }
    func getCompanyResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            if !response.isEmpty {
                if let success = response["success"].bool {
                  
                    if success == true {
                        if let companyCode = response["code"].string {
                            Helpers.setStringValueWithKey(companyCode, key: Constants.COMPANY_ID)
                        }
                        if let companyData = response.rawString(){
                            Helpers.setStringValueWithKey(companyData, key: Constants.COMPANY_DATA)
                        }
                       navigateToLogin()
                        
                    }else{
                        if let reson = response["msg"].string {
                            let popup = CustomAlertPopup.customOkayPopup("", msgBody: reson)
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        else {
            //need to handle
        }
    }
    

}
extension CompanySubDomailController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getCompanyResponse(data, statusCode: statusCode)
        }
        
    }
}
