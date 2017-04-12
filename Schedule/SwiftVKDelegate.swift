//
//  SwiftVKDelegate.swift
//  VKFriends
//
//  Created by Игорь Талов on 06.11.16.
//  Copyright © 2016 Игорь Талов. All rights reserved.
//

import Foundation
import SwiftyVK


class SwiftyVKDataManager: VKDelegate {
    
    let appID = "5967116"
    let scope: Set = [VK.Scope.messages,.offline,.groups,.status,.photos,.friends,.email]
    
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
                let id = response.array![0]["id"].intValue
                let firstName = response.array![0]["first_name"].stringValue
                let lastName = response.array![0]["last_name"].stringValue
                print(id)
                print(firstName)
                print(lastName)
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
        return UIApplication.shared.delegate!.window!!.rootViewController!
    }
    
    func login(){
        VK.logIn()
    }
    
    func logout(){
        VK.logOut()
    }
    
    func vkStatus() -> VK.States{
        return VK.state
    }
    
}