//
//  SideBarController.swift
//  ezzyride-app-ios
//
//  Created by Innovadeaus on 11/11/18.
//  Copyright © 2018 Innovadeus Pvt. Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher


class SideBarController: UIViewController {
    

    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var closeButt: UIButton!
    
    let placeholder = UIImage(named: "logo-text")
    let star = "☆"
    var myTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initSetup()
    
      
    }
    
    @objc func profileTapped(tapGestureRecognizer: UITapGestureRecognizer) {
      
        
        print("clicked")
    }
    
    @objc func userNameTapped(tapGestureRecognizer: UITapGestureRecognizer) {
       
    }

    @IBAction func closeButton(_ sender: Any) {
        (parent as? BaseController)?.showAndHide()
        
    }
}


extension SideBarController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.menuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? menuCell
        cell?.name.text = Constants.menuItem[indexPath.row]
        cell?.Icon.image = UIImage(named: "\(Constants.menuItemImage[indexPath.row]).png")
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (tableView.bounds.height / 7) - 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row

      if index == 0{
           navigateToDeshboard()
           isOpen = false
        
        }else if index == 1{
        navigateToAttendance()
         isOpen = false
        
        }else if index == 2{
        naviateToMyLeaveApplication()
         isOpen = false
        }else if index == 3{
        navigateToNotice()
         isOpen = false
        }else if index == 4{
          navigateToPersonalProfile()
         isOpen = false
        }else if index == 5 {
          navigateToHoliday()
         isOpen = false
      }else{
       Commons.destroyData()
       UIApplication.shared.keyWindow?.rootViewController = initViewController()
        isOpen = false
      }
        
        
    }
    func initViewController() -> UINavigationController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let login = mainStoryboard.instantiateViewController(withIdentifier: "login") as? LoginController
        let navigationController = UINavigationController()
        navigationController.viewControllers = [login!]
        return navigationController
    }
    func naviateToMyLeaveApplication(){
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "myLeave") as? LeaveBalanceController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func navigateToAttendance() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "myattendance") as? myAttendenceController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    func navigateToDeshboard() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "deshboard") as? DeshBoardController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func navigateToPersonalProfile() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "personal") as? personalProfileController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func navigateToNotice() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "notice") as? NoticeController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    func navigateToHoliday() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "holiday") as? HolidayCalendaeController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    


}





