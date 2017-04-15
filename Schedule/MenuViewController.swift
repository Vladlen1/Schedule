//
//  MenuViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 14.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let vkDelegate = SwiftyVKDataManager.sharedInstance

    @IBOutlet weak var userName: UILabel!
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        let firstName = UserDefaults.standard.value(forKey: "user_first_name") as! String
        let lastName = UserDefaults.standard.value(forKey: "user_last_name") as! String
        userName.text = lastName + " " + firstName

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
    

}
