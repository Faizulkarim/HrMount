//
//  clameController.swift
//  HRM
//
//  Created by Innovadeaus on 16/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON

class clameController: BaseController {
    @IBOutlet weak var eidulFitrBack: UIView!
    @IBOutlet weak var EidUlAdhaBack: UIView!
    @IBOutlet weak var pohelBoishakBack: UIView!
    @IBOutlet weak var increment: UILabel!
    @IBOutlet weak var EidFitrIsRecived: UILabel!
    @IBOutlet weak var eidUlAdhaIsRecived: UILabel!
    @IBOutlet weak var pohelaBoishakIsRecived: UILabel!
    @IBOutlet weak var lfaBack: UIView!
    @IBOutlet weak var leaveBack: UIView!
    @IBOutlet weak var pfBack: UIView!
    @IBOutlet weak var Gratuity: UIView!
    @IBOutlet weak var specialBounus: UIView!
    @IBOutlet weak var insentif: UIView!
    @IBOutlet weak var eidUlFitrAmmout: UILabel!
    @IBOutlet weak var eidUlAdhaAmmount: UILabel!
    @IBOutlet weak var lfa: UIImageView!
    @IBOutlet weak var leaveAndCashment: UIImageView!
    @IBOutlet weak var pf: UIImageView!
    @IBOutlet weak var GratuityImage: UIImageView!
    @IBOutlet weak var specialBounusImage: UIImageView!
    @IBOutlet weak var insatifImage: UIImageView!
    
    
    
    var apiCommunicatorHelper: APICommunicator?
    var userService : UserService?
    var claim: [JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        initGester()
        initView()
        initApiCommunicatorHelper()
        getClaim()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        userService = UserService(self.view, communicator: apiCommunicatorHelper!)
        
    }

    func getClaim(){
        userService?.getClaim()
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
    

    func initView(){
        
        eidulFitrBack.setShadow()
        EidUlAdhaBack.setShadow()
        pohelBoishakBack.setShadow()
        lfaBack.setShadow()
        leaveBack.setShadow()
        pfBack.setShadow()
        Gratuity.setShadow()
        specialBounus.setShadow()
        insentif.setShadow()
    }
    
    func showData(){
        if let increm = claim[0]["value"].string{
            self.increment.text = "INCREMENT \(increm)"
        }
        if let eidUlFitr = claim[1]["value"].string{
            self.eidUlFitrAmmout.text = eidUlFitr
        }
        if let eidUlAdha = claim[2]["value"].string{
            self.eidUlAdhaAmmount.text = eidUlAdha
        }
        if let lfaa = claim[4]["value"].bool{
            if !lfaa{
                self.lfa.image = UIImage(named: "Approved")
            }else{
                self.lfa.image = UIImage(named: "Rejected")
            }
        }
        if let LeaveCash = claim[5]["value"].bool{
            if !LeaveCash{
                self.leaveAndCashment.image = UIImage(named: "Approved")
            }else{
                self.leaveAndCashment.image = UIImage(named: "Rejected")
            }
        }
        if let pff = claim[6]["value"].bool{
            if !pff{
                self.pf.image = UIImage(named: "Approved")
            }else{
                self.pf.image = UIImage(named: "Rejected")
            }
        }
        if let Gratu = claim[7]["value"].bool{
            if !Gratu{
                self.GratuityImage.image = UIImage(named: "Approved")
            }else{
                self.GratuityImage.image = UIImage(named: "Rejected")
            }
        }
        if let specialB = claim[8]["value"].bool{
            if !specialB{
                self.specialBounusImage.image = UIImage(named: "Approved")
            }else{
                self.specialBounusImage.image = UIImage(named: "Rejected")
            }
        }
        if let insatifB = claim[9]["value"].bool{
            if !insatifB{
                self.insatifImage.image = UIImage(named: "Approved")
            }else{
                self.insatifImage.image = UIImage(named: "Rejected")
            }
        }
       
    }
    
    @IBAction func menuShow(_ sender: Any) {
        showAndHide()
    }
    func getClaimResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
 
                        if let data = response["data"].array{
                            claim = data
                            showData()
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
extension clameController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getClaimResponse(data, statusCode: statusCode)
        }
        
    }
}
