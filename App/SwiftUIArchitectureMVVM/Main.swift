//
//  swiftui_architecture_mvvmApp.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import App
import SwiftUI

@main
struct Main: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            rootScreen()
        }
    }
}
