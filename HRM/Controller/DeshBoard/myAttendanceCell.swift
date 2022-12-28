//
//  myAttendanceCell.swift
//  HRM
//
//  Created by Innovadeaus on 3/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class myAttendanceCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var inTime: UILabel!
    @IBOutlet weak var outTime: UILabel!
    @IBOutlet weak var flag: UILabel!
    
    @IBOutlet weak var isAttend: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
