//
//  HolidayCell.swift
//  HRM
//
//  Created by Innovadeaus on 25/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class HolidayCell: UITableViewCell {
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var toDate: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
