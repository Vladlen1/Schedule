//
//  SwiftVKDelegate.swift
//  VKFriends
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import SwiftyVK



class SwiftyVKDataManager: VKDelegate {
    
    var state = ""
    let appID = "5967116"
    let scope: Set = [VK.Scope.offline, .email]
    var vc : AuthenticationViewController?

    init() {
        VK.configure(withAppId: appID, delegate: self)
    }
    

    
    static let sharedInstance: SwiftyVKDataManager = {
        let instance = SwiftyVKDataManager ()
        return instance
    }()
    
    func vkWillAuthorize() -> Set<VK.Scope> {
        return scope
    }
    
    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        let userId = parameters["user_id"]!
        VK.API.Users.get([VK.Arg.userId : userId]).send(
            onSuccess: {response in
                let firstName = response.array![0]["first_name"].stringValue
                let lastName = response.array![0]["last_name"].stringValue
                let email = parameters["email"]?.lowercased()
                print(firstName)
                print(lastName)
                UserDefaults.standard.setValue(firstName, forKey: "user_first_name")
                UserDefaults.standard.setValue(lastName, forKey: "user_last_name")
                UserDefaults.standard.setValue(email, forKey: "email")
                
                if VK.state == .authorized {
                    
                    DispatchQueue.main.async {
        
                        self.vc?.vkAuthorizated()
                    }
                    
                }

        },
            onError: {error in print(error)}
        )
    }
    
    func vkDidUnauthorize() {

    }
    func vkAutorizationFailedWith(error: AuthError) {
        print("autorize failed with error: \n\(error)")
        
    }

    func vkShouldUseTokenPath() -> String? {
        return nil
    }


    func vkWillPresentView() -> UIViewController {
        return self.vc!
    }
    
    func login() {
        VK.logOut()
        VK.logIn()
    }
    
    func logout(){
        VK.logOut()
    }
    
    func vkStatus() -> VK.States{
        return VK.state
    }
    
}
