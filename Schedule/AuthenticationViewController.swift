//
//  RegistrationViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, GIDSignInUIDelegate {
    var i = 0
    let vkDelegate = SwiftyVKDataManager.sharedInstance
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self

    }
    
    @IBAction func signInVk(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork() == true {
            let serialPriorityQueue = DispatchQueue(label:"com.bestkora.serialPriority", qos: .userInitiated)
            serialPriorityQueue.async{self.vkDelegate.login()}
            serialPriorityQueue.async{
                if self.vkDelegate.vkStatus() == .authorized {
                    let nextViewController = self.storyBoard.instantiateViewController(withIdentifier: "TableViewController") as! SWRevealViewController
                    self.present(nextViewController, animated:true, completion:nil)
                }
            }
        } else {
            showAlertNoInternetConnect()
        }
    }

    
    @IBAction func signInGoogle(_ sender: Any) {
        if Reachability.isConnectedToNetwork() == true {
            GIDSignIn.sharedInstance().signIn()
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
