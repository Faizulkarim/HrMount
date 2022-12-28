//
//  noticeCell.swift
//  HRM
//
//  Created by Innovadeaus on 24/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit

class noticeCell: UITableViewCell {


    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
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
