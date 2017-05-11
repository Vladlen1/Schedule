//
//  RegistrationViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, GIDSignInUIDelegate {

    let vkDelegate = SwiftyVKDataManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self

    }
    
    @IBAction func signInVk(_ sender: UIButton) {
        self.vkDelegate.vc = self
        self.vkDelegate.login()

    }
    
    @IBAction func signInGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func vkAuthorizated() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController")
        self.present(vc!, animated: true, completion: nil)
        
    }
}
