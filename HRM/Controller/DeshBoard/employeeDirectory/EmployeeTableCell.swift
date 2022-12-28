//
//  EmployeeTableCell.swift
//  HRM
//
//  Created by Innovadeaus on 2/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class EmployeeTableCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var deignation: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var Employeeimage: UIImageView!
    @IBOutlet weak var imageBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
