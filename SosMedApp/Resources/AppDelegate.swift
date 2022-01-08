//
//  AppDelegate.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 07/01/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        isLogin()
        return true
    }
    
    func isLogin() {
        let statusLogin = UserDefaults.standard.string(forKey: "isLogin") ?? ""
        
        if statusLogin.localizedCaseInsensitiveContains("success") {
        
            let displayTabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
            displayTabBar.navigationItem.hidesBackButton = true
            self.window?.rootViewController = displayTabBar
            
        } else {
            
            let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            self.window?.rootViewController = signInVC
        }
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

