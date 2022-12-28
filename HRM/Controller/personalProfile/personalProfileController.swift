//
//  personalProfileController.swift
//  HRM
//
//  Created by Innovadeaus on 3/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import SwiftyJSON
import Photos
import Kingfisher

class personalProfileController: BaseController,UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var personalButton: UIButton!
    @IBOutlet weak var officialButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var personalView: UIView!
    @IBOutlet weak var officialView: UIView!
    @IBOutlet weak var other: UIView!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var titleInfo: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDesignation: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var nid: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var mobileNumbe: UILabel!
    @IBOutlet weak var fatherNumbe: UILabel!
    @IBOutlet weak var motherNumber: UILabel!
    @IBOutlet weak var employeeCode: UILabel!
    @IBOutlet weak var joinDate: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var funtionalDesignation: UILabel!
    @IBOutlet weak var jobStatus: UILabel!
    @IBOutlet weak var jobBase: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var emCategory: UILabel!
    @IBOutlet weak var bloodGroup: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    
    var userMobileNumbe = ""
    var userProfile: JSON = [:]
    var currUploadedPhoto = UIImage()
    let imagePicker = UIImagePickerController()
    var apiCommunicatorHelper: APICommunicator?
    var userService : UserService?
    override func viewDidLoad() {
        super.viewDidLoad()

        personImage.roundCornersForView(corners: [.topLeft, .bottomRight], radius: 35)
        officialView.isHidden = true
        other.isHidden = true
        let tapProfileImage = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        personImage.isUserInteractionEnabled = true
        personImage.addGestureRecognizer(tapProfileImage)
        initGester()
        ShowProfile()
        imagePicker.delegate = self
        initApiCommunicatorHelper()
         checkPhotoLibraryPermission()
        // Do any additional setup after loading the view.
    }
    
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        userService = UserService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    @objc func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if  isComFromEmployeeList == false {
             self.uploadPictureActionSheet()
        }
    }
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized: break
        case .denied, .restricted : break
        //handle denied status
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized: break
              
                case .denied, .restricted: break
                // as above
                case .notDetermined: break
                    // won't happen but still
                }
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func call(_ sender: Any) {
        if userMobileNumbe != "" {
            if isComFromEmployeeList == true{
                userMobileNumbe.doMakeAPhoneCall()
            }
        }else{
            let popup = CustomAlertPopup.customOkayPopup("", msgBody: "No number found")
            self.present(popup, animated: true, completion: nil)
        }
        
    }
    @IBAction func sms(_ sender: Any) {
        if userMobileNumbe != "" {
            if isComFromEmployeeList == true{
              userMobileNumbe.doSms()
            }
            
        }else{
            let popup = CustomAlertPopup.customOkayPopup("", msgBody: "No number found")
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    func ShowProfile(){
        if isComFromEmployeeList == false{
            let userInfo = Helpers.getStringValueForKey(Constants.USER_INFO)
            userProfile = JSON.init(parseJSON: userInfo)
            if let data = userProfile["data"].dictionary{
                if let userFirstName = data["first_name"]?.string {
                    let firstN = userFirstName
                    if let userLastName = data["last_name"]?.string {
                        self.userName.text = "\(firstN) \(userLastName)"
                    }
                }
                if let designation = data["designation"]?.string {
                    if designation != "" {
                        self.userDesignation.text = designation
                    }else{
                        self.userDesignation.text = "No data"
                    }
                    
                }
                if let image_url = data["avatar_url"]?.string {
                    let url = URL(string: image_url)
                    if image_url != "" {
                        personImage.kf.indicatorType = .activity
                        personImage.kf.setImage(with: url)
                    }else{
                        personImage.image = UIImage(named: "noImageAvater")
                    }
                    
                }
                if let dateOfBirth = data["date_of_birth"]?.string {
                    if dateOfBirth != "" {
                        self.dob.text = dateOfBirth
                    }else{
                        self.dob.text = "No data"
                    }
                }
                if let nidNumber = data["national_id"]?.string{
                    if nidNumber != "" {
                        self.nid.text = nidNumber
                    }else{
                        self.nid.text = "No data"
                    }
                }
                if let nationalityC = data["nationality"]?.string{
                    if nationalityC != "" {
                        self.nationality.text = nationalityC
                    }else{
                        self.nationality.text = "No data"
                    }
                }
                if let mobile = data["phone"]?.string{
                    if mobile != "" {
                        self.mobileNumbe.text = mobile
                        self.mobileNumber.text = mobile
                        
                    }else{
                        self.mobileNumbe.text = "No number given"
                        self.mobileNumber.text = "No number given"
                    }
                }
                if let fatherName = data["father_name"]?.string {
                    if fatherName != "" {
                        self.fatherNumbe.text = fatherName
                    }else{
                        self.fatherNumbe.text = "No data"
                    }
                }
                if let motherN = data["mother_name"]?.string{
                    if motherN != "" {
                        self.motherNumber.text = motherN
                    }else{
                        self.motherNumber.text = "No data"
                    }
                }
                if let eCode = data["employee_code"]?.string{
                    if eCode != "" {
                        self.employeeCode.text = eCode
                    }else{
                        self.employeeCode.text = "No data"
                    }
                }
                if let join = data["date_of_join"]?.string{
                    if join != "" {
                        self.joinDate.text = join
                    }else{
                        self.joinDate.text = "No data"
                    }
                }
                if let eDesignation = data["designation"]?.string{
                    if eDesignation != ""{
                        self.designation.text = eDesignation
                    }else{
                        self.designation.text = "No data"
                    }
                }
                if let functionD = data["functional_designation"]?.string{
                    if functionD != "" {
                        self.funtionalDesignation.text = functionD
                    }else{
                        self.funtionalDesignation.text = "No data"
                    }
                }
                if let jobStat = data["job_status"]?.string{
                    if jobStat != ""{
                        self.jobStatus.text = jobStat
                    }else{
                        self.jobStatus.text = "No data"
                    }
                }
                if let jobB = data[""]?.string{
                    if jobB != ""{
                        self.jobBase.text = jobB
                    }else{
                        self.jobBase.text = "No data"
                    }
                }
                if let eCat = data[""]?.string{
                    if eCat != ""{
                        self.emCategory.text = eCat
                    }else{
                        self.emCategory.text = "No data"
                    }
                }
                if let bGroup = data["blood_group"]?.string{
                    if bGroup != ""{
                        self.bloodGroup.text = bGroup
                    }else{
                        self.bloodGroup.text = "No data"
                    }
                }
                if let regi = data["region"]?.string{
                    if regi != "" {
                        self.region.text = regi
                    }else{
                        self.region.text = "No data"
                    }
                }
                if let gen = data[""]?.string {
                    if gen != "gender" {
                        self.gender.text = gen
                    }else{
                        self.gender.text = "No data"
                    }
                }
                
            }
        }else{
            let userInfo = Helpers.getStringValueForKey(Constants.EMPLOYEE_LIST)
            userProfile = JSON.init(parseJSON: userInfo)
            if let data = userProfile["data"][EmployeIndex].dictionary{
       
                if let userFirstName = data["first_name"]?.string {
                    let firstN = userFirstName
                    if let userLastName = data["last_name"]?.string {
                        self.userName.text = "\(firstN) \(userLastName)"
                    }
                }
                if let designation = data["designation"]?.string {
                    if designation != "" {
                        self.userDesignation.text = designation
                    }else{
                        self.userDesignation.text = "No data"
                    }
                    
                }
                if let image_url = data["avatar_url"]?.string {
                    let url = URL(string: image_url)
                    if image_url != "" {
                        personImage.kf.indicatorType = .activity
                        personImage.kf.setImage(with: url)
                    }else{
                        personImage.image = UIImage(named: "noImageAvater")
                    }
                    
                }
                if let dateOfBirth = data["date_of_birth"]?.string {
                    if dateOfBirth != "" {
                        self.dob.text = dateOfBirth
                    }else{
                        self.dob.text = "No data"
                    }
                }
                if let nidNumber = data["national_id"]?.string{
                    if nidNumber != "" {
                        self.nid.text = nidNumber
                    }else{
                        self.nid.text = "No data"
                    }
                }
                if let nationalityC = data["nationality"]?.string{
                    if nationalityC != "" {
                        self.nationality.text = nationalityC
                    }else{
                        self.nationality.text = "No data"
                    }
                }
                if let mobile = data["phone"]?.string{
                    if mobile != "" {
                        self.mobileNumbe.text = mobile
                        self.mobileNumber.text = mobile
                         userMobileNumbe = mobile
                    }else{
                        self.mobileNumbe.text = "No number given"
                        self.mobileNumber.text = "No number given"
                    }
                }
                if let fatherName = data["father_name"]?.string {
                    if fatherName != "" {
                        self.fatherNumbe.text = fatherName
                    }else{
                        self.fatherNumbe.text = "No data"
                    }
                }
                if let motherN = data["mother_name"]?.string{
                    if motherN != "" {
                        self.motherNumber.text = motherN
                    }else{
                        self.motherNumber.text = "No data"
                    }
                }
                if let eCode = data["employee_code"]?.string{
                    if eCode != "" {
                        self.employeeCode.text = eCode
                    }else{
                        self.employeeCode.text = "No data"
                    }
                }
                if let join = data["date_of_join"]?.string{
                    if join != "" {
                        self.joinDate.text = join
                    }else{
                        self.joinDate.text = "No data"
                    }
                }
                if let eDesignation = data["designation"]?.string{
                    if eDesignation != ""{
                        self.designation.text = eDesignation
                    }else{
                        self.designation.text = "No data"
                    }
                }
                if let functionD = data["functional_designation"]?.string{
                    if functionD != "" {
                        self.funtionalDesignation.text = functionD
                    }else{
                        self.funtionalDesignation.text = "No data"
                    }
                }
                if let jobStat = data["job_status"]?.string{
                    if jobStat != ""{
                        self.jobStatus.text = jobStat
                    }else{
                        self.jobStatus.text = "No data"
                    }
                }
                if let jobB = data[""]?.string{
                    if jobB != ""{
                        self.jobBase.text = jobB
                    }else{
                        self.jobBase.text = "No data"
                    }
                }
                if let eCat = data[""]?.string{
                    if eCat != ""{
                        self.emCategory.text = eCat
                    }else{
                        self.emCategory.text = "No data"
                    }
                }
                if let bGroup = data["blood_group"]?.string{
                    if bGroup != ""{
                        self.bloodGroup.text = bGroup
                    }else{
                        self.bloodGroup.text = "No data"
                    }
                }
                if let regi = data["region"]?.string{
                    if regi != "" {
                        self.region.text = regi
                    }else{
                        self.region.text = "No data"
                    }
                }
                if let gen = data[""]?.string {
                    if gen != "gender" {
                        self.gender.text = gen
                    }else{
                        self.gender.text = "No data"
                    }
                }
                
            }
        }

        
      
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func uploadPictureActionSheet() {
        
        let sheet = UIAlertController(title: "Upload Picture", message: nil, preferredStyle: .actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker,animated: true,completion: nil)
            }
            else{
                let popup = CustomAlertPopup.customOkayPopup("No Camera", msgBody: "This device has no camera!!!")
                self.present(popup, animated: true, completion: nil)
            }
        }
        
        let photoLibraryAction = UIAlertAction(title: "Choose from Gallery", style: .default) { (action) in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        sheet.addAction(takePhotoAction)
        sheet.addAction(photoLibraryAction)
        sheet.addAction(cancelAction)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            sheet.popoverPresentationController?.sourceView = self.view
            sheet.popoverPresentationController?.permittedArrowDirections = []
            sheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.height - 140, width: 0, height: 0)
            self.present(sheet, animated: true, completion: nil)
        }
        else {
            self.present(sheet, animated: true, completion: nil)
        }
    }
 
    
    @IBAction func personalTaped(_ sender: Any) {
        personalButton.setImage(UIImage(named: "Parsonalselect"), for: .normal)
        officialButton.setImage(UIImage(named: "OfficialUnselect"), for: .normal)
        otherButton.setImage(UIImage(named: "OthersUnselect"), for: .normal)
        other.fadeOut()
        officialView.fadeOut()
        personalView.fadeIn()
        titleInfo.text = "Personal Information"
//        other.animHide()
//        officialView.animHide()
        
    }
    @IBAction func officialTapped(_ sender: Any) {
        personalButton.setImage(UIImage(named: "ParsonalUnselect"), for: .normal)
        officialButton.setImage(UIImage(named: "Officialselect"), for: .normal)
        otherButton.setImage(UIImage(named: "OthersUnselect"), for: .normal)
        personalView.fadeOut()
        other.fadeOut()
        officialView.fadeIn()
         titleInfo.text = "Official Information"
//        personalView.animHide()
//        other.animHide()
        
    }
    @IBAction func otherTapped(_ sender: Any) {
        personalButton.setImage(UIImage(named: "ParsonalUnselect"), for: .normal)
        officialButton.setImage(UIImage(named: "OfficialUnselect"), for: .normal)
        otherButton.setImage(UIImage(named: "Othersselect"), for: .normal)
        personalView.fadeOut()
        officialView.fadeOut()
        other.fadeIn()
         titleInfo.text = "other Information"
//        personalView.animHide()
//        other.animHide()
        
    }
    
    @IBAction func showMenu(_ sender: Any) {
        showAndHide()
    }
    func doUploadProfilePicture(_ image: UIImage) {
        let data = image.pngData()
        let params = [
            "profile_image": image
        ]
        print(params)
        userService?.uploadProfileImage(params, imageData: data!)
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
    func getUploadProfilePictureResponse(_ data: [String: Any], statusCode: Int) {
        var success = false
        if statusCode == Constants.STATUS_CODE_SUCCESS{
            let response = JSON(data)
            print(response)
            if !response.isEmpty{
                if let updateChangeStatus = response["success"].bool {
                    success = updateChangeStatus
                    if success {
                        if let data = response["data"].dictionary {
                            if let url = data["avatar_url"]?.string {
                                
                                // We are using Kingfisher ImageLoading Library. No need to do it manually.
                                let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                                let profilePicURL = URL(string: urlString!)
                                personImage.kf.indicatorType = .activity
                                personImage.kf.setImage(with: profilePicURL)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    // self.getProfile()
                                }
                            }
                        }
                       
                    }
                    else{
                        if let reson = response["message"].string {
                            let popup = CustomAlertPopup.customOkayPopup("", msgBody: reson)
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }

    
    
}

extension personalProfileController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.SECOND {
            getUploadProfilePictureResponse(data, statusCode: statusCode)
        }
        
    }
}
extension personalProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)


        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            let image = Commons.resizeImage(pickedImage, targetSize: CGSize(width: Constants.RESZIE_IMAGE_WIDTH, height: Constants.RESZIE_IMAGE_HEIGHT))
            currUploadedPhoto = image
            doUploadProfilePicture(currUploadedPhoto)
        }
        self.dismiss(animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
