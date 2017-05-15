//
//  ScheduleView.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class ScheduleView: BaseView{
    var presenter = SchedulePresenter()
    
    override func viewDidLoad() {
        self.basePresenter = presenter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
