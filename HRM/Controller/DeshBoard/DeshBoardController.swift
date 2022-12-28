//
//  DeshBoardController.swift
//  HRM
//
//  Created by Innovadeaus on 1/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Alamofire

var isOpen = false
var isFromDeshBoard = false

class DeshBoardController: BaseController {


    @IBOutlet weak var deshboardCollectionView: UICollectionView!
    @IBOutlet weak var profileImageBack: UIView!
    @IBOutlet weak var DetailsIconImage: UIImageView!
    @IBOutlet weak var DetailsName: UILabel!
    @IBOutlet weak var detailsBackgroundView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDesignation: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var apiCommunicatorHelper: APICommunicator?
    var userService : UserService?
     var userProfile: JSON = [:]
    
    var secondPage = false
    var deshboardIndex = 0
   
    var deshboardImage = ["Attendance","Leave","Employee Directory","Claim","My Profile","Salary"]
    let attendanceImage = ["My Attendance","Attendance In-Out","Reconcilation List","Reconcilation"]

    let leaveImage = ["All Application","Leave list","Leave Balance","Request For Leave"]
    var initialImageArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        initialImageArray = deshboardImage
        self.profileImageBack.roundCornersForView(corners: [.topLeft, .bottomRight], radius: 55)
       detailsBackgroundView.isHidden = true
        isComFromEmployeeList = false
        initApiCommunicatorHelper()
        initGester()
        getProfile()
        ShowProfile()
       
        
        // Do any additional setup after loading the view.
    }
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        userService = UserService(self.view, communicator: apiCommunicatorHelper!)
        
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

    @IBAction func openMenu(_ sender: Any) {
        
       showAndHide()
    }
    
    func ShowProfile(){
       let userInfo = Helpers.getStringValueForKey(Constants.USER_INFO)
        userProfile = JSON.init(parseJSON: userInfo)
     
        if let data = userProfile["data"].dictionary{
               print(data)
            if let userFirstName = data["first_name"]?.string {
                let firstN = userFirstName
                if let userLastName = data["last_name"]?.string {
                    self.userName.text = "\(firstN) \(userLastName)"
                }
            }
            if let designation = data["designation"]?.string {
                self.userDesignation.text = designation
            }
            if let image_url = data["avatar_url"]?.string {
                let url = URL(string: image_url)
                if image_url != "" {
                    profileImage.kf.indicatorType = .activity
                    profileImage.kf.setImage(with: url)
                }else{
                    profileImage.image = UIImage(named: "noImageAvater")
                }
              
            }
        }
    }
    @IBAction func close(_ sender: Any) {
        initialImageArray = deshboardImage
        deshboardCollectionView.reloadData()
        detailsBackgroundView.isHidden = true
        secondPage = false
    }
    @IBAction func gotoAttendanceController(_ sender: Any) {
        naviagteToSelfAttendance()
    }
    func getProfile(){
        userService?.getProfile()
    }
    
    func initViewController() -> UINavigationController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let login = mainStoryboard.instantiateViewController(withIdentifier: "login") as? LoginController
        let navigationController = UINavigationController()
        navigationController.viewControllers = [login!]
        return navigationController
    }
    func getProfileResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)
            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        if let userInfo = response.rawString() {
                            Helpers.setStringValueWithKey(userInfo, key: Constants.USER_INFO)
                            ShowProfile()
                     
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

            Commons.destroyData()
            UIApplication.shared.keyWindow?.rootViewController = initViewController()
        }
    }
    
    func navigateToEmployeeDirectory() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "employeeDirectiory") as? EmployeeDirectoryController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func navigateToPersonalProfile() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "personal") as? personalProfileController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func navigateToAttendance() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "myattendance") as? myAttendenceController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func naviagteToSelfAttendance(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "selfattendance") as? SelfAttendanceController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func naviateToApplicationApprove(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "approveRecionApplication") as? AttendanceReconciliationList
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }

    func naviateToreconApplication(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "reconApplication") as? ReconcilationApproveController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func naviateToApplicationForLeave(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "applicationForLeave") as? ApplyforLeaveController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func naviateToVisitApplication(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "VisitApplication") as? VistiteApplicationController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func naviateToAllApplication(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "allApplication") as? AllApplicationController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func naviateToMyLeaveApplication(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "myLeave") as? LeaveBalanceController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func naviateToClaim(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "claim") as? clameController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func naviateToReoncilationAttendance(){
        DateForReconlication = ""
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "reconciliationAttendance") as? AttendanceReconciliationController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func naviateToSalary(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "salary") as? SalaryController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    

}
extension DeshBoardController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return initialImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DeshboardCollectionCell
        
        cell.icon.image = UIImage(named: initialImageArray[indexPath.row])
        cell.name.text = initialImageArray[indexPath.row]
        return cell
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let yourWidth = deshboardCollectionView.bounds.width/4.0
            let yourHeight:Float = 120.0
                return  CGSize(width: yourWidth, height: CGFloat(yourHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if secondPage == false {
            deshboardIndex = indexPath.row
            secondPage = true
            if indexPath.row == 0 {
                detailsBackgroundView.isHidden = false
                initialImageArray = attendanceImage
                deshboardCollectionView.reloadData()
                DetailsIconImage.image = UIImage(named: deshboardImage[indexPath.row])
                DetailsName.text = deshboardImage[indexPath.row]
            }
            if indexPath.row == 1 {
                detailsBackgroundView.isHidden = false
                initialImageArray = leaveImage
                deshboardCollectionView.reloadData()
                DetailsIconImage.image = UIImage(named: deshboardImage[indexPath.row])
                DetailsName.text = deshboardImage[indexPath.row]
            }
            if indexPath.row == 2 {
                navigateToEmployeeDirectory()
            }
            if indexPath.row == 3 {
                naviateToClaim()
            }
            if indexPath.row == 4{
                navigateToPersonalProfile()
            }
            if indexPath.row == 5 {
                naviateToSalary()
            }
        }else{
            if deshboardIndex == 0 {
                if indexPath.row == 0 {
                    navigateToAttendance()
                }
                if indexPath.row == 1 {
                    naviagteToSelfAttendance()
                }
                if indexPath.row == 2 {
                  naviateToApplicationApprove()
                }
                if indexPath.row == 3{
                    naviateToReoncilationAttendance()
                   
                }
                if indexPath.row == 4{
                    naviateToreconApplication()
                }
                if indexPath.row == 5{
                    
                }
            }else if deshboardIndex == 1 {
                if indexPath.row == 0 {
                    naviateToAllApplication()
                }else if indexPath.row == 1{
                      naviateToAllApplication()
                    
                }else if indexPath.row == 2{
                    naviateToMyLeaveApplication()
                }else if indexPath.row == 3 {
                 naviateToApplicationForLeave()
                }else if indexPath.row == 4{
                 naviateToVisitApplication()
                }else if indexPath.row == 5 {
                 
                }
            }
        }

       
        
    }
    
    
    
}

extension DeshBoardController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getProfileResponse(data, statusCode: statusCode)
        }
        
    }
}

