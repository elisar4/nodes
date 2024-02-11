//  AppDelegate.swift
//  Created by Vladimir Roganov on 11.02.2024

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    let wnd = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        wnd.rootViewController = ViewController()
        wnd.makeKeyAndVisible()
        return true
    }
}
