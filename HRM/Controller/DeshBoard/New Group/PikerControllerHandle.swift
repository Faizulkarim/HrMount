//
//  HomePikerControllerHandle.swift
//  ezzyride-app-ios
//
//  Created by Innovadeaus on 4/2/19.
//  Copyright © 2019 Innovadeus Pvt. Ltd. All rights reserved.
//

import UIKit
extension ApplyforLeaveController {
    func createEndpiker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donepressEnd))
        toolbar.setItems([done], animated: false)
        toDate.inputAccessoryView = toolbar
        toDate.inputView = picker
        picker.datePickerMode = .dateAndTime
    }
    @objc func donepressEnd(){
        
        let dateFormater = DateFormatter()
        let timeFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormater.string(from: picker.date)
        timeFormater.dateFormat = "hh:mm a"

            toDate.text = "   \(dateString)"
          
            self.view.endEditing(true)
    }
    func createStartpiker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donepress))
        toolbar.setItems([done], animated: false)
        fromDate.inputAccessoryView = toolbar
        fromDate.inputView = picker
        picker.datePickerMode = .dateAndTime
    }
    @objc func donepress(){
        
        let dateFormater = DateFormatter()
        let timeFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormater.string(from: picker.date)
        timeFormater.dateFormat = "hh:mm a"
        self.fromDate.text = "   \(dateString)"
        self.view.endEditing(true)
        
    }
   
}
