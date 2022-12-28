//
//  salaryCellCell.swift
//  HRM
//
//  Created by Innovadeaus on 25/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class salaryCellCell: UITableViewCell {
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var isReceave: UIImageView!
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
