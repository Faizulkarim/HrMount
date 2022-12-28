//
//  SalaryController.swift
//  HRM
//
//  Created by Innovadeaus on 25/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON

class SalaryController: BaseController {
    @IBOutlet weak var totalSalaryView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var apiCommunicatorHelper: APICommunicator?
    var userService : UserService?
    var salary: [JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        initApiCommunicatorHelper()
        totalSalaryView.setShadow()
        getSalary()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func showAndHide(_ sender: Any) {
        showAndHide()
    }
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        userService = UserService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    func getSalary(){
        userService?.getSalary()
    }
    func getSalaryResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        if let data = response["data"].array {
                            salary = data
                            tableView.reloadData()
                        }
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
            
            
        }
    }



}
extension SalaryController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return salary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? salaryCellCell
        
        if let ammmoutM = salary[indexPath.row]["total_amount"].int{
            cell?.amount.text = "\(ammmoutM)"
        }
        if let mont = salary[indexPath.row]["salary_of_month"].string{
            cell?.month.text = "\(mont)"
        }
        cell?.backView.setShadow()
        if let receaveState = salary[indexPath.row]["status"].int{
            if  receaveState == 1{
                cell?.isReceave.image = UIImage(named: "Recived")
            }else{
                cell?.isReceave.image = UIImage(named: "Not-Recived")
            }
        }
        
        return cell!
    }
    
    
}
extension SalaryController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getSalaryResponse(data, statusCode: statusCode)
        }
        
    }
}
