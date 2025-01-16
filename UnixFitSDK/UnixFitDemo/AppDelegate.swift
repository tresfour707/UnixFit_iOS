//
//  AppDelegate.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 11.12.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow?  = {
        UIWindow(frame: UIScreen.main.bounds)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = MachineListViewController()
        let navVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

}

