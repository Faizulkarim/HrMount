//
//  ApplicationDetailsController.swift
//  HRM
//
//  Created by Innovadeaus on 14/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON

class ApplicationDetailsController: UIViewController {
    @IBOutlet weak var rejectedbyHr: UIButton!
    @IBOutlet weak var recon: UIButton!
    @IBOutlet weak var resonText: UITextView!
    @IBOutlet weak var ApplicationText: UITextView!
    @IBOutlet weak var resonHeigh: NSLayoutConstraint!
    @IBOutlet weak var ApplicationHeight: NSLayoutConstraint!
    @IBOutlet weak var dateString : UILabel!
    @IBOutlet weak var leaveDate: UILabel!
    @IBOutlet weak var applicationTitle: UILabel!
    
    var allApplist: JSON = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        rejectedbyHr.roundCornersForView(corners: [.topLeft, .bottomRight], radius: 20)
        recon.roundCornersForView(corners: [.topLeft, .bottomRight], radius: 20)
        ShowDetails()
        // Do any additional setup after loading the view.
    }
    
    func ShowDetails(){
        let allAppD = Helpers.getStringValueForKey(Constants.ALLAPPLICATION_LIST)
        allApplist = JSON.init(parseJSON: allAppD)
        if let data = allApplist["data"].array{
            if let date = data[allAppIndex]["applied_on"].string{
                 let applyDate = Commons.formattedDateFromString(dateString: date, withFormat: "MMM dd, yyyy")
                self.dateString.text = "Apply Date: \(applyDate ?? "")"
            }
            if let leaveDateFrom = data[allAppIndex]["leave_from"].string{
                if let leaveDateTo = data[allAppIndex]["leave_to"].string{
                    let finalToDate = Commons.formattedDateFromString(dateString: leaveDateTo, withFormat: "MMM dd, yyyy")
                    
                    let finalFromDate = Commons.formattedDateFromString(dateString: leaveDateFrom, withFormat: "MMM dd, yyyy")
                    self.leaveDate.text = "From: \(finalFromDate ?? "") TO: \(finalToDate ?? "")"
                }
            }
            if let remarks = data[allAppIndex]["remark"].string{
                if remarks != "" {
                    self.resonText.text = remarks
                }else{
                    resonHeigh.constant = 0.0
                }
            }
            if let leaveReson = data[allAppIndex]["leave_reason"].string{
                self.ApplicationText.text = leaveReson
            }
            if let status = data[allAppIndex]["status"].string{
                if status == "approved" {
                   
                rejectedbyHr.setTitle("Approved By HR", for: .normal)
                    
                }else if status == "rejected" {
                     rejectedbyHr.setTitle("Rejected By HR", for: .normal)
                }else {
                   rejectedbyHr.setTitle("Pending", for: .normal)
                    
                }
            }
            if let leaveType = data[allAppIndex]["ltype_name"].string{
                    self.applicationTitle.text = "Application For \(leaveType)"
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    func navigateToReconciliation() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "reconsidaration") as? reconciliationController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func reconciliation(_ sender: Any) {
        navigateToReconciliation()
    }
    
    

}
