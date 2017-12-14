//
//  AppDelegate.swift
//  ARBookCharacterAnimation
//
//  Created by Christopher Webb-Orenstein on 12/13/17.
//  Copyright © 2017 Christopher Webb. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: MainCoordinator!
    
    // MARK: - App Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            appCoordinator = MainCoordinator(window: window)
        }
        return true
    }
}

