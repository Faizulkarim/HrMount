//
//  reconciliationController.swift
//  HRM
//
//  Created by Innovadeaus on 14/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class reconciliationController: UIViewController {
    @IBOutlet weak var applicationText: UITextView!
    @IBOutlet weak var excuseText: UITextView!
    
    @IBOutlet weak var requestButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        requestButton.roundCornersForView(corners: [.topLeft, .bottomRight], radius: 20)
        applicationText.layer.borderWidth = 1
        applicationText.layer.borderColor = Commons.colorWithHexString("FF7711").cgColor
        excuseText.layer.borderWidth = 1
        excuseText.layer.borderColor = Commons.colorWithHexString("FF7711").cgColor
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func reonsideration(_ sender: Any) {
        
    }
    


}
