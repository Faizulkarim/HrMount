//
//  NoticeController.swift
//  HRM
//
//  Created by Innovadeaus on 24/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON
var notice: [JSON] = []
var noticeIndex = 0
class NoticeController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    var apiCommunicatorHelper: APICommunicator?
    var userService : UserService?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        initGester()
        initApiCommunicatorHelper()
         getNotification()
        // Do any additional setup after loading the view.
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
    func getNotification(){
        userService?.getNotice()
    }
    
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        userService = UserService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    func getNoticeResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        if let data = response["data"].array {
                           notice = data
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
    func naviateToNoticeDetails(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "noticeDetails") as? NoticeDetailsController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }


}

extension NoticeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return notice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? noticeCell
        
        if let dateTime = notice[indexPath.row]["created_at"].string{
            cell?.date.text = Commons.convertDateToString(dateString: dateTime, FomatedString: "MMM dd,yyyy")
        }
        cell?.backView.setShadow()
        
        if let title = notice[indexPath.row]["title"].string{
           cell?.title.text = title
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noticeIndex = indexPath.row
        naviateToNoticeDetails()
    }
    
    
}
extension NoticeController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getNoticeResponse(data, statusCode: statusCode)
        }
        
    }
}
