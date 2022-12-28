//
//  EmployeeDirectoryController.swift
//  HRM
//
//  Created by Innovadeaus on 2/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

var isComFromEmployeeList = false
var EmployeIndex = 0
class EmployeeDirectoryController: BaseController {
    @IBOutlet weak var tableView: UITableView!
      var apiCommunicatorHelper: APICommunicator?
    var employeListService : UserService?
    var employeeInit: JSON = [:]
    var employeList : [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGester()
        initApiCommunicatorHelper()
        getAllEmployeeList()
        showEmployeeList()
    }
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        employeListService = UserService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    
    func showEmployeeList(){
        
        let employeeInfo = Helpers.getStringValueForKey(Constants.EMPLOYEE_LIST)
        employeeInit = JSON.init(parseJSON: employeeInfo)
        print(employeeInit)
        if let data = employeeInit["data"].array {
            print(data)
            employeList = data
            
            tableView.reloadData()
        }
      
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
  
    func initGester(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    @objc func moveToNextItem(_ sender:UISwipeGestureRecognizer) {
        switch sender.direction{
        case .left:
            if isOpen == true {
                showAndHide()
            }
        case .right:
            if isOpen == false {
                showAndHide()
            }
            
        default: break //default
        }
        
    }
    func getAllEmployeeList(){
      employeListService?.getAllEmployeeList()
    }
    
    @IBAction func showMenu(_ sender: Any) {
        showAndHide()
    }
    func getAllEmployeeListResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        
                        if let userInfo = response.rawString() {
                            Helpers.setStringValueWithKey(userInfo, key: Constants.EMPLOYEE_LIST)
                            showEmployeeList()
                            
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
            //need to handle
        }
    }
    
    func navigateToPersonalProfile() {
        isComFromEmployeeList = true
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "personal") as? personalProfileController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }

    
}
extension EmployeeDirectoryController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return employeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EmployeeTableCell
        cell?.imageBack.roundCornersForView(corners: [.topLeft, .bottomRight], radius: 20)
        cell?.shadowView.setShadow()
        if let fName  = employeList[indexPath.row]["first_name"].string {
            let firstN = fName
            if let lName = employeList[indexPath.row]["last_name"].string {
                cell?.name.text = "\(firstN) \(lName)"
            }
        }
        if let eCode = employeList[indexPath.row]["employee_code"].string{
            cell?.code.text = eCode
        }
        if let dnation = employeList[indexPath.row]["designation"].string {
            cell?.deignation.text = dnation
        }
        if let dment = employeList[indexPath.row]["department"].string{
            cell?.department.text = dment
        }
        if let image_url = employeList[indexPath.row]["avatar_url"].string {
            let url = URL(string: image_url)
            if image_url != "" {
                cell?.Employeeimage.kf.indicatorType = .activity
                cell?.Employeeimage.kf.setImage(with: url)
            }else{
                cell?.Employeeimage.image = UIImage(named: "no_avatar_big")
            }
          
        }

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        EmployeIndex = indexPath.row
        isComFromEmployeeList = true
        navigateToPersonalProfile()
    }
    
    
}
extension EmployeeDirectoryController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getAllEmployeeListResponse(data, statusCode: statusCode)
        }
        
    }
}
