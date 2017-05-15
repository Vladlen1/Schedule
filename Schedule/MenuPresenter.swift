//
//  MenuPresenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class MenuPresenter: BasePresenter{
    
    let vkDelegate = SwiftyVKDataManager.sharedInstance
    var viewToDraw : MenuView?
    
    var menuController: MenuViewController?
    
    
    func load(){
            self.viewToDraw?.setNumberGroupString(numberGroup: "Group la la la")
            self.viewToDraw?.setUserNameString(userName: "User lalala")
    
    }
    
    func exitWithAccount() {
        if vkDelegate.vkStatus() == .authorized {
            vkDelegate.logout()
            
            let nextViewController = self.menuController?.storyBoard.instantiateViewController(withIdentifier: "RegistrationController") as! AuthenticationViewController
            self.menuController?.present(nextViewController, animated:true, completion:nil)

        }
        if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            GIDSignIn.sharedInstance().signOut()
            
            let nextViewController = self.menuController?.storyBoard.instantiateViewController(withIdentifier: "RegistrationController") as! AuthenticationViewController
            self.menuController?.present(nextViewController, animated:true, completion:nil)
            
        }
    }
    
    func newGroup() {
        let nextViewController = self.menuController?.storyBoard.instantiateViewController(withIdentifier: "AddScheduleController") as! AddScheduleController
        self.menuController?.present(nextViewController, animated:true, completion:nil)
        
    }
    
    func changeGroup() {
        let nextViewController = self.menuController?.storyBoard.instantiateViewController(withIdentifier: "GroupTableController") as! GroupTableController
        self.menuController?.present(nextViewController, animated:true, completion:nil)
    }
}
