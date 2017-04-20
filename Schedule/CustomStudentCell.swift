//
//  CustomStudentCell.swift
//  Schedule
//
//  Created by Влад Бирюков on 20.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class CustomStudentCell: UITableViewCell {

    @IBOutlet weak var nameStudent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
