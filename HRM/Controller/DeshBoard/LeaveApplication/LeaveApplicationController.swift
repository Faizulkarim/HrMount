//
//  LeaveApplicationController.swift
//  HRM
//
//  Created by Innovadeaus on 4/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class AllApplicationController: UIViewController {
    @IBOutlet weak var leaveAppButton: UIButton!
    @IBOutlet weak var visisteAppButton: UIButton!
    @IBOutlet weak var all: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var count = 15
    
    let color = Commons.colorWithHexString("FF7711")
    override func viewDidLoad() {
        super.viewDidLoad()
        visitAppBorderColor()
        leaveAppBorderColor()
        initGester()

        
        // Do any additional setup after loading the view.
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
        count = 10
        tableView.reloadData()
        
    }
    
    @IBAction func visitApp(_ sender: Any) {
        visisteAppButton.backgroundColor = color
        visisteAppButton.setTitleColor(UIColor.white, for: .normal)
        leaveAppBorderColor()
        allAppBorderColor()
        count = 5
        tableView.reloadData()
    }
    @IBAction func allApp(_ sender: Any) {
        all.backgroundColor = color
        all.setTitleColor(UIColor.white, for: .normal)
        leaveAppBorderColor()
        visitAppBorderColor()
        count = 15
        tableView.reloadData()
        
    }
    
    @objc func showAndHide(){
        
        if(!isOpen)
            
        {
            isOpen = true
            
            let menuVC : SideBarController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! SideBarController
            self.view.addSubview(menuVC.view)
            self.addChild(menuVC)
            menuVC.view.layoutIfNeeded()
            
            menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width+100, height: UIScreen.main.bounds.size.height);
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            }, completion:nil)
            
        }else if(isOpen)
        {
            isOpen = false
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
                
            })
        }
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
            showAndHide()
        case .right:
            showAndHide()
        default: break //default
        }
        
    }
    
    func navigateToApplicationDetails() {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetails = main.instantiateViewController(withIdentifier: "appDetails") as? ApplicationDetailsController
        let navigationController = UINavigationController(rootViewController: tripDetails!)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }


}
extension LeaveApplicationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? allApplicationCell
        cell?.BackView.setShadow()
        cell?.applicationType.layer.cornerRadius = 10
        cell?.applicationType.clipsToBounds = true
  
        if indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7 {
            cell?.applicationType.text = "V"
        }
        
        return cell!
    }
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToApplicationDetails()
    }
    
}
