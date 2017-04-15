//
//  AppDelegate.swift
//  Schedule
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    let vkDelegate = SwiftyVKDataManager.sharedInstance
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        GIDSignIn.sharedInstance().delegate = self
        
        
        if !(checkAuthorizationUser())
        {
            let mainController = storyboard.instantiateViewController(withIdentifier: "RegistrationController")
            self.window?.rootViewController = mainController
        }
        else
        {
            let altController = storyboard.instantiateViewController(withIdentifier: "TableViewController")
            self.window?.rootViewController = altController
        }
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    private func checkAuthorizationUser() -> Bool{
        if vkDelegate.vkStatus() != .authorized && !GIDSignIn.sharedInstance().hasAuthInKeychain() {
            return false
        }else{
            return true
        }
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
                withError error: Error!) {
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
//            let userId = user.userID                  
//            let idToken = user.authentication.idToken
//            let name = user.profile.name
//            let email = user.profile.email
            let lastName = user.profile.familyName
            let firstName = user.profile.givenName
            
            
            print(lastName!)
            print(firstName!)
//            print(name!)
//            print(email!)
            UserDefaults.standard.setValue(firstName, forKey: "user_first_name")
            UserDefaults.standard.setValue(lastName, forKey: "user_last_name")
            
            let altController = storyboard.instantiateViewController(withIdentifier: "TableViewController")
            self.window?.rootViewController = altController
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
