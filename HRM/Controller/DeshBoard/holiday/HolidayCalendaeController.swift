//
//  HolidayCalendaeController.swift
//  HRM
//
//  Created by Innovadeaus on 25/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON

class HolidayCalendaeController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    
    var attendanceService : AttendanceService?
    var apiCommunicatorHelper: APICommunicator?
    var holiday: [JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()
          initGester()
          initApiCommunicatorHelper()
          getHoliday()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func showMenu(_ sender: Any) {
        showAndHide()
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
    func getHoliday(){
        attendanceService?.getHolidayList()
    }

    
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        attendanceService = AttendanceService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    func getHolydayResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        
                        if let data = response["data"].array {
                            holiday = data
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
extension HolidayCalendaeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holiday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HolidayCell
        
        if let day = holiday[indexPath.row]["no_of_days"].string{
            cell?.days.text = "\(day) DAYS"
        }
        if let titleName = holiday[indexPath.row]["title"].string{
            cell?.title.text = titleName
        }
        if let fromDate = holiday[indexPath.row]["from_date"].string {
            if let todate = holiday[indexPath.row]["from_date"].string{
                let finalDate = Commons.formattedDateFromString(dateString: todate, withFormat: "MMM dd, yyyy")
         
                let finalFromDate = Commons.formattedDateFromString(dateString: fromDate, withFormat: "MMM dd, yyyy")
                cell?.toDate.text = "\(finalFromDate ?? "") - To - \(finalDate ?? "")"
            }
        }
        cell?.backView.setShadow()
       
        
        return cell!
    }
    
    
}

extension HolidayCalendaeController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getHolydayResponse(data, statusCode: statusCode)
        }
        
    }
}
