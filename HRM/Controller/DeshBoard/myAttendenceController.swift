//
//  myAttendenceController.swift
//  HRM
//
//  Created by Innovadeaus on 3/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON

var DateForReconlication = ""
class myAttendenceController: BaseController {
    @IBOutlet weak var attendanceListTableView: UITableView!
    var attendanceService : AttendanceService?
    var apiCommunicatorHelper: APICommunicator?
    var myAttendance : [JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        initGester()
        initApiCommunicatorHelper()
        getAttendance()
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
    
    @IBAction func menuShow(_ sender: Any) {
        showAndHide()
    }
    
    func getAttendance(){
       attendanceService?.doGetAttendance()
    }
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        if let date = myAttendance[buttonTag]["date"].string{
            DateForReconlication = date
            naviateToReoncilationAttendance()
        }

    }
    func naviateToReoncilationAttendance(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "reconciliationAttendance") as? AttendanceReconciliationController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func getAllAttendanceResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                    
                        if let data = response["data"].dictionary {
                            if let items = data["items"]?.array {
                              myAttendance = items
                              attendanceListTableView.reloadData()
                            }
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

extension myAttendenceController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myAttendance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? myAttendanceCell
        if let date = myAttendance[indexPath.row]["date"].string{
            cell?.date.text = date
        }
        if let inTime = myAttendance[indexPath.row]["clock_in"].string {
            cell?.inTime.text = inTime
        }
        if let outTime = myAttendance[indexPath.row]["clock_out"].string {
            cell?.outTime.text = outTime
        }
        if let flage = myAttendance[indexPath.row]["flag"].string{
            cell?.flag.text = flage
        }
        if let Action = myAttendance[indexPath.row]["attendance"].string {
            cell?.flag.text = Action
        }
        cell?.isAttend.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
           cell?.isAttend.tag = indexPath.row
        
        return cell!
    }
    
    
}
extension myAttendenceController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getAllAttendanceResponse(data, statusCode: statusCode)
        }
        
    }
}
