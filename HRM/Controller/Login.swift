//
//  ViewController.swift
//  HRM
//
//  Created by Innovadeaus on 1/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
class LoginController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var passwordTe: UITextField!
    
    var CompanyJson : JSON = [:]
    var authenticationService: AuthenticationService?
    var apiCommunicatorHelper: APICommunicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initApiCommunicatorHelper()
        signIn.roundCorners(corners: [.bottomRight,.bottomLeft , .topLeft, .topRight], radius: 20)
        getCompayData()
        userName.delegate = self
        passwordTe.delegate = self
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func getCompayData(){
        let companyData = Helpers.getStringValueForKey(Constants.COMPANY_DATA)
        CompanyJson = JSON.init(parseJSON: companyData)
        if let comData = CompanyJson["data"].dictionary {
            print(comData)
            if let logoString = comData["logo"]?.string {
                let urlString = logoString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let url = URL(string: urlString!)
                self.companyLogo.kf.setImage(with: url)
            }
        }
        
    }
    
    @IBAction func login(_ sender: Any) {
        if userName.text != "" && passwordTe.text != "" {
          doLogin()
        }else{
            let popup = CustomAlertPopup.customOkayPopup("", msgBody: "User name or password is missing")
            self.present(popup, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func haveAnotheCompany(_ sender: Any) {
        Helpers.removeValue(Constants.COMPANY_ID)
        Helpers.removeValue(Constants.COMPANY_DATA)
        UIApplication.shared.keyWindow?.rootViewController = initViewController()
    }
    func initViewController() -> UINavigationController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let login = mainStoryboard.instantiateViewController(withIdentifier: "companySub") as? CompanySubDomailController
        let navigationController = UINavigationController()
        navigationController.viewControllers = [login!]
        return navigationController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        authenticationService = AuthenticationService(self.view, communicator: apiCommunicatorHelper!)
       
    }
    func doLogin() {
        let username = userName.text!
        let passwordText = passwordTe.text!
        let params = [
            "user_name": username,
            "password": passwordText,
    
        ]
        print(params)
        authenticationService?.doLogin(params)
    }
    func navigateToDeshboard() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "deshboard") as? DeshBoardController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func getLoginResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            var success = false
            if !response.isEmpty {
                if let loginStatus = response["success"].bool {
                    success = loginStatus
                    if success == true {
                        if let data = response["data"].dictionary {
                            if let token = data["token"]?.string {
                                Helpers.setStringValueWithKey(token, key: Constants.ACCESS_TOKEN)
                            }
                            if let user_id = data["user_id"]?.int {
                                Helpers.setIntValueWithKey(user_id, key: Constants.USER_ID)
                            }
                            else if let user_id = data["user_id"]?.string {
                                Helpers.setIntValueWithKey(Int(user_id)!, key: Constants.USER_ID)
                            }
                        }
                        
                        
                        navigateToDeshboard()
                        
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

extension LoginController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getLoginResponse(data, statusCode: statusCode)
        }
     
    }
}

