//
//  AppDelegate.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    var objectConfigurator: ObjectConfigurator?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if window == nil {
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
        }
        if objectConfigurator == nil {
            objectConfigurator = ObjectConfigurator()
        }
        let menuManager = objectConfigurator?.menuManager()
        if let menuViewController = menuManager?.menuViewController() {
            if navigationController == nil {
                navigationController = UINavigationController()
            }
            navigationController?.viewControllers = [menuViewController]
            window!.rootViewController = navigationController
        }
        window?.makeKeyAndVisible()
        return true
    }
}

