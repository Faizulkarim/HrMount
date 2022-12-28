//
//  LeaveBalanceController.swift
//  HRM
//
//  Created by Innovadeaus on 4/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class LeaveBalanceController: BaseController {

    @IBOutlet weak var sickLeaveView: UIView!
    @IBOutlet weak var earnLeaveView: UIView!
    @IBOutlet weak var sickLeft: UIView!
    @IBOutlet weak var earnLeft: UIView!
    @IBOutlet weak var maternityView: UIView!
    @IBOutlet weak var maternityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGester()
        view(vw: sickLeaveView)
        view(vw: earnLeaveView)
        view(vw: sickLeft)
        view(vw: earnLeft)
        maternityView.layer.cornerRadius = 50
        maternityView.layer.masksToBounds = false
//         view(vw: maternityView)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func view(vw: UIView){
        let shadowRadius: CGFloat = 5
        vw.layer.shadowRadius = shadowRadius
        vw.layer.shadowOffset = CGSize(width: 0, height: 5)
        vw.layer.shadowOpacity = 0.5
        
        // how strong to make the curling effect
        let curveAmount: CGFloat = 10
        let shadowPath = UIBezierPath()
        
        // the top left and right edges match our view, indented by the shadow radius
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: vw.frame.width - shadowRadius, y: 0))
        
        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: vw.frame.width - shadowRadius, y: vw.frame.height + curveAmount))
        
        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: vw.frame.height + curveAmount), controlPoint1: CGPoint(x: vw.frame.width, y: vw.frame.height - shadowRadius), controlPoint2: CGPoint(x: 0, y: vw.frame.height - shadowRadius))
        vw.layer.shadowPath = shadowPath.cgPath
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
    
}


