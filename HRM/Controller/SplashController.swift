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
        let userId = Helpers.getIntValueForKey(Constants.USER_ID)
        if companyID != "" {
            if userId != -1 {
                
            }
        }
    }

}
