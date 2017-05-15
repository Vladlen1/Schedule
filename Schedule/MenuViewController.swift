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
    
    let vkDelegate = SwiftyVKDataManager.sharedInstance
//    private var emailUser = UserDefaults.standard.value(forKey: "email") as! String

    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let menuPresenter = MenuPresenter()

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var groupNumber: UILabel!
    @IBOutlet weak var menuView: MenuView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuPresenter.load()
        self.menuPresenter.menuController = self
        
        self.baseViews = [self.menuView]
        self.menuView.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
//        let firstName = UserDefaults.standard.value(forKey: "user_first_name") as! String
//        let lastName = UserDefaults.standard.value(forKey: "user_last_name") as! String
//        userName.text = lastName + " " + firstName
//        
//        let schedules = try! Realm().objects(ScheduleGroup.self)
//        for schedule in schedules{
//            if schedule.acrivite == true && schedule.email == emailUser{
//                groupNumber.text = "\(schedule.groupNumber)/\(schedule.subGroup)"
//            }
//        }
        
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
