//
//  NavigationRouterDemoApp.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 07/03/24.
//

import SwiftUI

@main
struct NavigationRouterDemoApp: App {
    @AppStorage("login") var login: Bool = false
    var body: some Scene {
        WindowGroup {
            if login {
                AppTabbarView()
            } else {
                LoginView()
            }
        }
    }
}
