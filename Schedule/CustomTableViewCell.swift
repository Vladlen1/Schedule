//
//  CustomTableViewCell.swift
//  Schedule
//
//  Created by Влад Бирюков on 17.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var numberOfPeople: UILabel!
    @IBOutlet weak var nameTeacher: UILabel!
    @IBOutlet weak var typePair: UILabel!
    @IBOutlet weak var nameSubject: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
