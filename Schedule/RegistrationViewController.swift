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
        if Reachability.isConnectedToNetwork() == true {
            vkDelegate.login()
            if vkDelegate.vkStatus() == .authorized {
                self.performSegue(withIdentifier: "showTable", sender: self)
            }
        } else {
            showAlertNoInternetConnect()
        }
    }
    
    @IBAction func signInGoogle(_ sender: Any) {
        if Reachability.isConnectedToNetwork() == true {
            GIDSignIn.sharedInstance().signIn()
            if GIDSignIn.sharedInstance().hasAuthInKeychain(){
                self.performSegue(withIdentifier: "showTable", sender: self)

            }
        } else {
            showAlertNoInternetConnect()
        }
    }
    
    private func showAlertNoInternetConnect(){
        let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
        
}
