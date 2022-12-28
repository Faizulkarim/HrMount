//
//  ApproveApplicationController.swift
//  HRM
//
//  Created by Innovadeaus on 4/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON


class AttendanceReconciliationList: BaseController {

    @IBOutlet weak var tableView: UITableView!
    var attendanceService : AttendanceService?
    var apiCommunicatorHelper: APICommunicator?
    var myReconList: [JSON] = []
    var count = 15
    
    let color = Commons.colorWithHexString("FF7711")
    override func viewDidLoad() {
        super.viewDidLoad()
        initGester()
        initApiCommunicatorHelper()
        getReconAList()
        
        // Do any additional setup after loading the view.
    }
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        attendanceService = AttendanceService(self.view, communicator: apiCommunicatorHelper!)
        
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
    func getReconAList(){
        attendanceService?.getReconciliationList()
    }
    
    @IBAction func menuShow(_ sender: Any) {
        showAndHide()
    }
    
    func navigateToApplicationDetails() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "appDetails") as? ApplicationDetailsController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func getAllAttendanceReconListResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        
                        if let data = response["data"].array {
                           
                                myReconList = data
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
            //need to handle
        }
    }
    
}
extension AttendanceReconciliationList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myReconList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ApplicationCell
       cell?.backView.setShadow()
        if let datetext = myReconList[indexPath.row]["date"].string {
            let dat =  Commons.convertDate(dateString: datetext, FomatedString: "MMM dd")
             cell?.date.text = dat
        }
        if let status = myReconList[indexPath.row]["status"].string {
            if status == "approved" {
                cell?.isApprove.image = UIImage(named: "Approved")
                
            }else if status == "rejected" {
                cell?.isApprove.image = UIImage(named: "Rejected")
            }else {
                cell?.isApprove.image = UIImage(named: "Pending")
                
            }
            
        }
        if let leaveReason = myReconList[indexPath.row]["message"].string{
            cell?.reason.text = leaveReason
        }
       
       
        
        return cell!
    }
    
    
}

extension AttendanceReconciliationList: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getAllAttendanceReconListResponse(data, statusCode: statusCode)
        }
        
    }
}
