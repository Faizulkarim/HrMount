//
//  BaseViewController.swift
//  BarTest
//
//  Created by faizul hasan on 3/24/17.
//  Copyright © 2017 faizul hasan. All rights reserved.
//

import UIKit


 var senderTrack = 0

class BaseController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            return
        }
    }


}

