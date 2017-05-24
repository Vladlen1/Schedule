//
//  ScheduleController.swift
//  Schedule
//
//  Created by Влад Бирюков on 14.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleController: BaseViewController {
    
    @IBOutlet weak var scheduleView : ScheduleView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addMenuButton(flag: true)
        
        self.scheduleView.scheduleController = self
        self.baseViews = [self.scheduleView]
        
        self.scheduleView.viewDidLoad()
        
     
    }
}

