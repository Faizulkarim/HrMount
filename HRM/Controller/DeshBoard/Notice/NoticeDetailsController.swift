//
//  NoticeDetailsController.swift
//  HRM
//
//  Created by Innovadeaus on 24/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class NoticeDetailsController: UIViewController {
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var titleDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ShowData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func ShowData(){

        if let titleN = notice[noticeIndex]["title"].string {
           self.titleName.text = "\(titleN)"
        }
        if let details = notice[noticeIndex]["description"].string {
            let dText = details.convertHTML()
            let myString = Commons.newAttrSize(blockQuote: dText)
           self.titleDetails.attributedText = myString
            
        }
    }

}
