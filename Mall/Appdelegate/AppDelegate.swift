//
//  AppDelegate.swift
//  Mall
//
//  Created by iOS on 2022/2/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        self.performSetup(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        debugPrint("程序进入后台");
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        debugPrint("程序将要进入前台");
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("程序激活");
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("程序终止")
    }

}

