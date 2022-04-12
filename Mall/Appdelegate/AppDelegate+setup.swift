//
//  AppDelegate+setup.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import Foundation
import UIKit


extension AppDelegate {
    
    
    func performSetup(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.dynamicColor(UIColor.white, darkColor: UIColor.black)
        
        self.window?.rootViewController = MMMainTabBarController()
        
        self.window?.makeKeyAndVisible()
        
    }
    
    
}
