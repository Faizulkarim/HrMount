//
//  menuCell.swift
//  ezzyride-app-ios
//
//  Created by Innovadeaus on 11/11/18.
//  Copyright © 2018 Innovadeus Pvt. Ltd. All rights reserved.
//

import UIKit

class menuCell: UITableViewCell {
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
