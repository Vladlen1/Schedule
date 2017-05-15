//
//  ScheduleController.swift
//  Schedule
//
//  Created by Влад Бирюков on 14.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleController: BaseViewController, UIGestureRecognizerDelegate {

    let schedulePresenter = SchedulePresenter()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var scheduleView : ScheduleView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.schedulePresenter.scheduleController = self
        self.baseViews = [self.scheduleView]
        self.scheduleView.viewDidLoad()
        schedulePresenter.load()

    }
    
}


//extension ScheduleController: UITextFieldDelegate, UIGestureRecognizerDelegate{
//
//}
