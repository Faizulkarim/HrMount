//
//  AttendanceReconciliationController.swift
//  HRM
//
//  Created by Innovadeaus on 16/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON

class AttendanceReconciliationController: BaseController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var myView: GMSMapView!
    @IBOutlet weak var excuse: UITextView!
    @IBOutlet weak var dateField: UITextField!
    
    @IBOutlet weak var reconciliationButton: UIButton!
    var attendanceService : AttendanceService?
    var apiCommunicatorHelper: APICommunicator?
    var picker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initGester()
        initApiCommunicatorHelper()
        self.dateField.delegate = self
        self.excuse.delegate = self
        self.excuse.returnKeyType = UIReturnKeyType.done
        self.dateField.text = DateForReconlication
        createStartpiker()
        // Do any additional setup after loading the view.
    }
    func createStartpiker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donepress))
        toolbar.setItems([done], animated: false)
        dateField.inputAccessoryView = toolbar
        dateField.inputView = picker
        picker.datePickerMode = .dateAndTime
    }
    @objc func donepress(){
        
        let dateFormater = DateFormatter()
        let timeFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormater.string(from: picker.date)
        timeFormater.dateFormat = "hh:mm a"
        self.dateField.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        attendanceService = AttendanceService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    
    func initView(){
    excuse.layer.borderColor = Commons.colorWithHexString("FF7711").cgColor
    excuse.layer.borderWidth = 1
 
    reconciliationButton.roundCorners(corners: [.topLeft, .bottomRight], radius: 20 )
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
    func naviateToApplicationApprove(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "approveRecionApplication") as? AttendanceReconciliationList
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func requestForReonciliation(_ sender: Any) {
        let excu = excuse.text.count
        if excu > 10 {
            if dateField.text != "" {
                  postReconciliationAttendence()
            }else{
                let popup = CustomAlertPopup.customOkayPopup("", msgBody: "Date is required")
                self.present(popup, animated: true, completion: nil)
            }
        }else{
            let popup = CustomAlertPopup.customOkayPopup("", msgBody: "Excuse must be more than 50 characters")
            self.present(popup, animated: true, completion: nil)
        }
      
        
    }
    
    func postReconciliationAttendence(){
        let date = dateField.text!
        let ex = excuse.text!
        let params = [
            "date": "\(date)",
            "message": "\(ex)",
          
            
        ]
        attendanceService?.doAttendanceReconciliation(params)
        print(params)
        
    }

    @IBAction func showAndHide(_ sender: Any) {
        showAndHide()
    }
    func getReconcilitonRespons(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                       naviateToApplicationApprove()
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
extension AttendanceReconciliationController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getReconcilitonRespons(data, statusCode: statusCode)
        }
        
    }
}
