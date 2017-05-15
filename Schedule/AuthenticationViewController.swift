//
//  RegistrationViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class AuthenticationViewController: BaseViewController, GIDSignInUIDelegate{

    let authenticationPresenter = AuthenticationPresenter()
    
    @IBOutlet weak var authenticationView: AuthenticationView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authenticationPresenter.authenticationController = self
        
        self.baseViews = [self.authenticationView]
        self.authenticationView.viewDidLoad()
        
    }
    
    @IBAction func signInVk(_ sender: UIButton) {
        authenticationPresenter.signInVk()
    }
    
    @IBAction func signInGoogle(_ sender: Any) {
        authenticationPresenter.signInGoogle()
    }
    
}
