//
//  AuthenticationPresenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class AuthenticationPresenter: BasePresenter , GIDSignInUIDelegate{
    
    let vkDeledate = SwiftyVKDataManager.sharedInstance
    var authenticationController: AuthenticationViewController?
    
    func signInVk() {
        self.vkDeledate.vc  = self
        self.vkDeledate.login()
    }

    func signInGoogle() {
        GIDSignIn.sharedInstance().uiDelegate = self.authenticationController!
        GIDSignIn.sharedInstance().signIn()
    }
    
    func vkAuthorizated() {
        let vc = self.authenticationController?.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")
        self.authenticationController?.present(vc!, animated: true, completion: nil)
    }
}
