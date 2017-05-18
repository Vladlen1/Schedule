////
////  VisitStidentController.swift
////  Schedule
////
////  Created by Влад Бирюков on 20.04.17.
////  Copyright © 2017 Влад Бирюков. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
class VisitStudentController: BaseViewController{
    
    let visitPresenter = VisitPresenter()
    
    @IBOutlet var tableView: UITableView!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        self.visitPresenter.visitController = self
        
        visitPresenter.load()
    }
    
}
