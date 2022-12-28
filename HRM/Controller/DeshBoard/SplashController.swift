//
//  SplashController.swift
//  HRM
//
//  Created by Innovadeaus on 21/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class SplashController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        goToController()
        // Do any additional setup after loading the view.
    }
    

    func goToController() {
        let companyID = Helpers.getStringValueForKey(Constants.COMPANY_ID)
  
        if companyID != "" {
            let userId = Helpers.getIntValueForKey(Constants.USER_ID)
            print(userId)
            if userId != -1 {
                navigateToDeshBoard()
            }else{
                navigateTologin()
            }
        }else{
           navigateToCompany()
        }
    }

    func navigateTologin() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "login") as? LoginController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func navigateToCompany() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "companySub") as? CompanySubDomailController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func navigateToDeshBoard() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "deshboard") as? DeshBoardController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
