//
//  HomeViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signInVk"{
            let registration =  segue.destination as! RegistrationViewController
            registration.typeRegistration = "vk"

        }else if segue.identifier == "signInGmail"{
            let registration =  segue.destination as! RegistrationViewController
            registration.typeRegistration = "google"
        }
    }
    
    @IBAction func signInVk(_ sender: UIButton) {
//        print("lel")
        self.performSegue(withIdentifier: "signInVk", sender: self)
    }
    
    @IBAction func signInGmail(_ sender: UIButton) {
//        print("kek")
        self.performSegue(withIdentifier: "signInGmail", sender: self)
    }
}
