//
//  AppDelegate.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 07.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let builder = MainViewAssembly()
        
        window?.rootViewController = builder.assemble()
        window?.makeKeyAndVisible()
        
        return true
    }
}

