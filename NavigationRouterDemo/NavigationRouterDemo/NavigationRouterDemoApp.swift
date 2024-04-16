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
    let router = Router<AppRoute>()
    var body: some Scene {
        WindowGroup {
            /// Uncomment below code to run app with Tabbar
//            AppTabbarView()
            
            /// Uncomment below code to run app without Tabbar
//            RoutingView(router: router, AppRoute.self) {
//                MyAccountView(router: router)
//            }
        }
    }
}
