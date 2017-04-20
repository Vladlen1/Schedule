//
//  GroupTableViewCell.swift
//  Schedule
//
//  Created by Влад Бирюков on 20.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var group: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
