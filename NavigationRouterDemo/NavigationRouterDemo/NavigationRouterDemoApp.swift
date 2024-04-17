//
//  NavigationRouterDemoApp.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 07/03/24.
//

import SwiftUI
import MyRouteManager

@main
struct NavigationRouterDemoApp: App {
    @AppStorage("login") var login: Bool = false
    let router = Router<AppRoute>()
    var body: some Scene {
        WindowGroup {
            /// Uncomment below code to run app with Tabbar
            AppTabbarView()
            
            /// Uncomment below code to run app without Tabbar
//            RoutingView(router: router, AppRoute.self) {
//                MoviesView(router: router) /// Example screen 1
//                MyAccountView(router: router) /// Example screen 2
//                    .onOpenURL { url in
//                        openURL(url, router: router)
//                    }
//            }
        }
    }
}

func openURL(_ url: URL, router: Router<AppRoute>) {
    var isValidPath = true
    let components = url.pathComponents.filter { component in
        component != "/"
    }
    guard !components.isEmpty else {
        return
    }
    let routes =  components.compactMap { component in
        let queryData = URLComponents(string: url.absoluteString)?.queryItems?.first?.value
        if let routeInfo = AppRouteInfo(path: component, data: queryData) {
            let route = AppRoute(routeInfo: routeInfo)
            return route
        } else {
            isValidPath = false
            return nil
        }
    }
    if isValidPath {
        let pathPresent = router.isPathPresent(path: url.path())
        router.handleDeeplink(routes: routes, isPathPresentInThisStack: pathPresent)
    } else {
        router.popToRoot()
    }
}
