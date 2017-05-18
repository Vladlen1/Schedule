//
//  AddScheduleController.swift
//  Schedule
//
//  Created by Влад Бирюков on 18.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift


class AddScheduleController: UITableViewController {

    @IBOutlet weak var university: UITextField!
    @IBOutlet weak var faculty: UITextField!
    @IBOutlet weak var group: UITextField!
    @IBOutlet weak var subgroup: UITextField!
        
    let addSchedulePresenter = AddSchedulePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSchedulePresenter.addScheduleController = self

        self.addSchedulePresenter.load()
        
    }
    
    @IBAction func addNewSchedule(_ sender: UIBarButtonItem) {
        addSchedulePresenter.addNewSchedule()
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        addSchedulePresenter.cancel()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
