//
//  LeaveApplicationController.swift
//  HRM
//
//  Created by Innovadeaus on 4/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON


var allAppIndex = 0
class AllApplicationController: BaseController {
    @IBOutlet weak var leaveAppButton: UIButton!
    @IBOutlet weak var visisteAppButton: UIButton!
    @IBOutlet weak var all: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var allApp : [JSON] = []
    let color = Commons.colorWithHexString("FF7711")
    var apiCommunicatorHelper: APICommunicator?
    var allApplicationService: AllApplicaionService?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        visitAppBorderColor()
        leaveAppBorderColor()
        initGester()
        initApiCommunicatorHelper()
        getAllAppList(type: "")
        

        
        // Do any additional setup after loading the view.
    }
 
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        allApplicationService = AllApplicaionService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func visitAppBorderColor(){
        visisteAppButton.layer.borderColor = Commons.colorWithHexString("FF7711").cgColor
        visisteAppButton.layer.borderWidth = 1
        visisteAppButton.setTitleColor(UIColor.black, for: .normal)
        visisteAppButton.backgroundColor = UIColor.white
    }
    func leaveAppBorderColor(){
        leaveAppButton.layer.borderColor = Commons.colorWithHexString("FF7711").cgColor
        leaveAppButton.layer.borderWidth = 1
        leaveAppButton.setTitleColor(UIColor.black, for: .normal)
        leaveAppButton.backgroundColor = UIColor.white
    }
    func allAppBorderColor(){
        all.layer.borderColor = Commons.colorWithHexString("FF7711").cgColor
        all.layer.borderWidth = 1
        all.setTitleColor(UIColor.black, for: .normal)
        all.backgroundColor = UIColor.white
    }
    @IBAction func leaveApp(_ sender: Any) {
        leaveAppButton.backgroundColor = color
        leaveAppButton.setTitleColor(UIColor.white, for: .normal)
        visitAppBorderColor()
        allAppBorderColor()

        getAllAppList(type: "?type=leave")

        
    }
    
    @IBAction func visitApp(_ sender: Any) {
        visisteAppButton.backgroundColor = color
        visisteAppButton.setTitleColor(UIColor.white, for: .normal)
        leaveAppBorderColor()
        allAppBorderColor()

        getAllAppList(type: "?type=visit")

    }
    @IBAction func allApp(_ sender: Any) {
        all.backgroundColor = color
        all.setTitleColor(UIColor.white, for: .normal)
        leaveAppBorderColor()
        visitAppBorderColor()
         getAllAppList(type: "")
       
     
        
    }
    
    func getAllAppList(type: String){
        allApplicationService?.getAllApplication(type: type)
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
    
    func navigateToApplicationDetails() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "appDetails") as? ApplicationDetailsController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func menuShow(_ sender: Any) {
        showAndHide()
    }
    

}
extension AllApplicationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allApp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? allApplicationCell
        cell?.BackView.setShadow()
        cell?.applicationType.layer.cornerRadius = 12.5
        cell?.applicationType.clipsToBounds = true
  
        if let ApplicationType = allApp[indexPath.row]["application_type"].string {
            cell?.applicationType.text = ApplicationType
            
        }
        if let status = allApp[indexPath.row]["status"].string {
            if status == "approved" {
                cell?.isApprove.image = UIImage(named: "Approved")
                
            }else if status == "rejected" {
                cell?.isApprove.image = UIImage(named: "Rejected")
            }else {
                cell?.isApprove.image = UIImage(named: "Pending")
                
            }
            
        }
        if let date = allApp[indexPath.row]["applied_on"].string{
           let dateT = Commons.convertDate(dateString: date, FomatedString:  "MMM dd")
            cell?.time.text = "\(dateT)"
        }
        if let leaveReason = allApp[indexPath.row]["leave_reason"].string{
            cell?.content.text = leaveReason
        }
        
        return cell!
    }
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        allAppIndex = indexPath.row
        navigateToApplicationDetails()
    }
    func getAllAppResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        
                        if let data = response["data"].array {
                            allApp.removeAll()
                            allApp = data
                            Helpers.removeValue(Constants.ALLAPPLICATION_LIST)
                            if let allAppInfo = response.rawString() {
                                   Helpers.setStringValueWithKey(allAppInfo, key: Constants.ALLAPPLICATION_LIST)
                            }
                       
                            tableView.reloadData()
                        }
                    }else{
                        if let reson = response["msg"].string {
                            let popup = CustomAlertPopup.customOkayPopup("", msgBody: reson)
                            self.present(popup, animated: true, completion: nil)
                             allApp.removeAll()
                            Helpers.removeValue(Constants.ALLAPPLICATION_LIST)
                            tableView.reloadData()
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
extension AllApplicationController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getAllAppResponse(data, statusCode: statusCode)
        }
        
    }
}
