//
//  MenuViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 14.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: BaseViewController {
    
    let menuPresenter = MenuPresenter()

    @IBOutlet weak var menuView: MenuView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuPresenter.menuController = self
        
        self.baseViews = [self.menuView]
        self.menuView.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func exitWithAccount(_ sender: UIButton) {
        menuPresenter.exitWithAccount()
    }
    
    @IBAction func newGroup(_ sender: UIButton) {
        menuPresenter.newGroup()
        
    }
    
    @IBAction func changeGroup(_ sender: UIButton) {
        menuPresenter.changeGroup()

    }
    

}
