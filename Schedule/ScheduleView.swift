//
//  ScheduleView.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class ScheduleView: BaseView{
    
    @IBOutlet var presenter: SchedulePresenter!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var scheduleController: ScheduleController!
    
    override func viewDidLoad() {
        self.basePresenter = presenter
        self.presenter.scheduleView = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func reloadTableView(){
        self.tableView.reloadData()
    }
    
    func startSpinner() {
        self.spinner.startAnimating()
    }
    
    func stopSpinner(){
        self.spinner.stopAnimating()
    }
}
