//
//  MenuViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 14.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController {
    
    let vkDelegate = SwiftyVKDataManager.sharedInstance
    private var emailUser = UserDefaults.standard.value(forKey: "email") as! String

    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var groupNumber: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        let firstName = UserDefaults.standard.value(forKey: "user_first_name") as! String
        let lastName = UserDefaults.standard.value(forKey: "user_last_name") as! String
        userName.text = lastName + " " + firstName
        
        let schedules = try! Realm().objects(ScheduleGroup.self)
        for schedule in schedules{
            if schedule.acrivite == true && schedule.email == emailUser{
                groupNumber.text = "\(schedule.groupNumber)/\(schedule.subGroup)"
            }
        }
        
    }
    
    @IBAction func exitWithAccount(_ sender: UIButton) {
        if vkDelegate.vkStatus() == .authorized {
            vkDelegate.logout()
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationController") as! AuthenticationViewController
            self.present(nextViewController, animated:true, completion:nil)
        }
        if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            GIDSignIn.sharedInstance().signOut()
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationController") as! AuthenticationViewController
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    @IBAction func newGroup(_ sender: UIButton) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddScheduleController") as! AddScheduleController
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func changeGroup(_ sender: UIButton) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GroupTableController") as! GroupTableController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    

}
