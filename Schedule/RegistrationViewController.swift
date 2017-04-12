//
//  RegistrationViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, GIDSignInUIDelegate {
    
    let vkDelegate = SwiftyVKDataManager.sharedInstance

    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self

    }
    
    @IBAction func signInVk(_ sender: UIButton) {
        if vkDelegate.vkStatus() != .authorized {
            vkDelegate.login()
        }
//        GIDSignIn.sharedInstance().signOut()
    }
    
    @IBAction func signInGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
}
