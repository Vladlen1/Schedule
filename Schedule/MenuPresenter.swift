//
//  MenuPresenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class MenuPresenter: BasePresenter {
    
    let emailUser = UserDefaults.standard.value(forKey: "email") as! String
    let firstName = UserDefaults.standard.value(forKey: "user_first_name") as! String
    let lastName = UserDefaults.standard.value(forKey: "user_last_name") as! String
    
    var userArr = [UserSchedule]()
    
    let vkDelegate = SwiftyVKDataManager.sharedInstance
    var viewToDraw : MenuView?
    
    var menuController: MenuViewController?
    
    
    func getUserInform(userName: String, numberGroup: String) {
            self.viewToDraw?.setNumberGroupString(numberGroup: numberGroup)
            self.viewToDraw?.setUserNameString(userName: userName)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getUserInform(userName: lastName + " " + firstName, numberGroup: getCurrentUserGroup())
    }
    
    private func getCurrentUserGroup() -> String {
        var groupNumber = ""
        getUser()
        for user in userArr {
            if user.email == emailUser && user.activite == true {
                groupNumber = user.groupNumber + "/" + user.subgroup
            }
        }
        return groupNumber
        
    }
    
    private func getUser() {
        let _ = UserInteractor().execute().subscribe(onNext: {obj in
            self.userArr.append(obj)
        }, onError: {error in
        }, onCompleted: {
            print("Complete")
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
    }
    
    func exitWithAccount() {
        if vkDelegate.vkStatus() == .authorized {
            vkDelegate.logout()
            
            let nextViewController = self.menuController?.storyboard?.instantiateViewController(withIdentifier: "RegistrationController") as! AuthenticationViewController
            self.menuController?.present(nextViewController, animated:true, completion:nil)

        }
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            GIDSignIn.sharedInstance().signOut()
            
            let nextViewController = self.menuController?.storyboard?.instantiateViewController(withIdentifier: "RegistrationController") as! AuthenticationViewController
            self.menuController?.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    func newGroup() {
        let nextViewController = self.menuController?.storyboard?.instantiateViewController(withIdentifier: "AddScheduleController") as! AddScheduleController
        self.menuController?.present(nextViewController, animated:true, completion:nil)
    }
    
    func changeGroup() {
        let nextViewController = self.menuController?.storyboard?.instantiateViewController(withIdentifier: "GroupTableController") as! GroupTableController
        self.menuController?.present(nextViewController, animated:true, completion:nil)
    }
}
