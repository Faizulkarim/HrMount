//
//  ApplyforLeaveController.swift
//  HRM
//
//  Created by Innovadeaus on 4/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ApplyforLeaveController: BaseController, UITextFieldDelegate, UITextViewDelegate  {

    @IBOutlet weak var leaveTypetableView: UITableView!
    @IBOutlet weak var titleBackView: UIView!
    @IBOutlet weak var selectedLeaveType: UITextField!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    @IBOutlet weak var purpose: UITextView!
    @IBOutlet weak var applyButton: UIButton!
    var leaveID = 0
    var leaveType: [JSON] = []
    let color = Commons.colorWithHexString("FF7711")
    var leaveService : LeaveService?
    var apiCommunicatorHelper: APICommunicator?
    var picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewSetUp()
        initGester()
        leaveTypetableView.isHidden = true
        leaveTypetableView.layer.borderColor = UIColor.gray.cgColor
        leaveTypetableView.layer.borderWidth = 1
        initApiCommunicatorHelper()
        selectedLeaveType.delegate = self
        fromDate.delegate = self
        toDate.delegate = self
        purpose.delegate = self
        purpose.returnKeyType = UIReturnKeyType.done
        getLeaveType()
        createStartpiker()
        createEndpiker()
        
        // Do any additional setup after loading the view.
    }
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        leaveService = LeaveService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    func initViewSetUp(){
        titleBackView.roundCornersForView(corners: [.topLeft, .bottomRight], radius: 24)
        applyButton.roundCornersForView(corners: [.topLeft, .bottomRight], radius: 20)
        selectedLeaveType.layer.borderWidth = 1
        selectedLeaveType.layer.borderColor = color.cgColor
        fromDate.layer.borderWidth = 1
        fromDate.layer.borderColor = color.cgColor
        toDate.layer.borderWidth = 1
        toDate.layer.borderColor = color.cgColor
        purpose.layer.borderWidth = 1
        purpose.layer.borderColor = color.cgColor
   
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
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
    @IBAction func downArrow(_ sender: Any) {
        leaveTypetableView.isHidden = false
    }
    
    @IBAction func apply(_ sender: Any) {
        if fromDate.text != "" && toDate.text != "" && purpose.text != "" && leaveID != 0{
              applyForLeave()
        }else{
            let popup = CustomAlertPopup.customOkayPopup("", msgBody: "Some field is missing")
            self.present(popup, animated: true, completion: nil)
        }
      
    }
    @IBAction func Menu(_ sender: Any) {
        showAndHide()
    }
    func getLeaveType(){
        leaveService?.doGetleaveType()
        
    }
    func applyForLeave(){
        
        let leaveFrom = fromDate.text?.replacingOccurrences(of: " ", with: "")
        let leaveTo = toDate.text?.replacingOccurrences(of: " ", with: "")
        let leaveReson = purpose.text
        
        let params = [
            "leave_from": leaveFrom,
            "leave_to": leaveTo,
            "leave_type_id": "\(leaveID)",
            "leave_reason": "\(leaveReson ?? "")"
            
        ]
        leaveService?.doRequestForLeave(params)
        print(params)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
          leaveTypetableView.isHidden = false
        }else{
          leaveTypetableView.isHidden = true
        }
        
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.resignFirstResponder()
        
        return true
    }
    func naviateToAllApplication(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "allApplication") as? AllApplicationController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func leaveRequestResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        fromDate.text = ""
                        toDate.text = ""
                        purpose.text = ""
                        selectedLeaveType.text = ""
                        
                    self.naviateToAllApplication()
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

    func getAllLeaveTypeResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        
                        if let data = response["data"].array {
                            leaveType = data
                            leaveTypetableView.reloadData()
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
extension ApplyforLeaveController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leaveType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaveTypeCell
        
        if let leaveTypeName = leaveType[indexPath.row]["leave"].string {
            cell?.name.text = leaveTypeName
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        leaveTypetableView.isHidden = true
       if let leaveText = leaveType[indexPath.row]["leave"].string {
            selectedLeaveType.text = "   \(leaveText)"
        }
        if let leaveid  = leaveType[indexPath.row]["id"].int{
            leaveID = leaveid
            print(leaveid)
        }
    }
   
}
extension ApplyforLeaveController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getAllLeaveTypeResponse(data, statusCode: statusCode)
        }
        if methodTag == MethodTags.SECOND {
            leaveRequestResponse(data, statusCode: statusCode)
        }
        
        
    }
}
