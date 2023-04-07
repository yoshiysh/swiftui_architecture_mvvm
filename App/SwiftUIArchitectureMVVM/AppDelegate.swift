//
//  AppDelegate.swift
//  Production
//
//  Created by Yoshiki Hemmi on 2023/04/07.
//

import App
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        registerProviderFactories()
        return true
    }
}
