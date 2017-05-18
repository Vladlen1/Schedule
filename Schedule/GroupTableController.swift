//
//  GroupTableController.swift
//  Schedule
//
//  Created by Влад Бирюков on 25.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift

class GroupTableController: BaseViewController {
    
    let groupTablePresenter = GroupTablePresenter()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupTablePresenter.groupController = self
        
        groupTablePresenter.load()
        
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        groupTablePresenter.cancel()
    }
}
