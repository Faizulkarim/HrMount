//
//  allApplicationCell.swift
//  HRM
//
//  Created by Innovadeaus on 14/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class allApplicationCell: UITableViewCell {
    @IBOutlet weak var applicationType: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var isApprove: UIImageView!
    
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var isApproveBackGround: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
