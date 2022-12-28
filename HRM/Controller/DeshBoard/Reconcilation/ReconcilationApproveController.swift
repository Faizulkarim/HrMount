//
//  ReconcilationApproveController.swift
//  HRM
//
//  Created by Innovadeaus on 4/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class ReconcilationApproveController: BaseController {
    @IBOutlet weak var leaveAppButton: UIButton!
    @IBOutlet weak var visisteAppButton: UIButton!
    let color = Commons.colorWithHexString("FF7711")
    override func viewDidLoad() {
        super.viewDidLoad()
        visitAppBorderColor()
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
    @IBAction func leaveApp(_ sender: Any) {
        leaveAppButton.backgroundColor = color
        leaveAppButton.setTitleColor(UIColor.white, for: .normal)
        visitAppBorderColor()
    }
    
    @IBAction func visitApp(_ sender: Any) {
        visisteAppButton.backgroundColor = color
        visisteAppButton.setTitleColor(UIColor.white, for: .normal)
        leaveAppBorderColor()
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

}
