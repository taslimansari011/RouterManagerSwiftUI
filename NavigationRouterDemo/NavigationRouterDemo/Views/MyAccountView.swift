//
//  MyAccountView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 19/03/24.
//

import SwiftUI

struct MyAccountView: View {
    @AppStorage("login") var login: Bool = false
    @StateObject var router: Router<AppRoute>
    let listData = ["Profile", "Saved List", "My Reviews", "Write to us"]
    var body: some View {
        List(listData, id: \.self) { data in
            HStack {
                Text(data)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .onTapGesture {
                if data == "Profile" {
                    router.routeTo(AppRoute(routeInfo: AppRouteInfo.profileScreen1))
                } else {
                    router.routeTo(AppRoute(routeInfo: AppRouteInfo.defaultScreen(message: data)))
                }
            }
        }
        .navigationTitle("My Account")
        .toolbar {
            if login {
                Button("Logout") {
                    login = false
                }
            }
        }
        .onOpenURL { url in
            openURL(url: url)
        }
    }
    
    private func openURL(url: URL) {
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
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView(router: Router<AppRoute>())
    }
}

// MARK: - ProfileScreen1

struct ProfileScreen1: View {
    @StateObject var router: Router<AppRoute>
    var body: some View {
        Button("Goto Screen 2") {
            router.routeTo(AppRoute(routeInfo: AppRouteInfo.profileScreen2(data: "No data yet")))
        }
        .navigationTitle("ProfileScreen1")
    }
}

// MARK: - ProfileScreen2

struct ProfileScreen2: View {
    @StateObject var router: Router<AppRoute>
    let queryData: String
    var body: some View {
        VStack {        
            Text("Query Data: \(queryData)").bold()
            Button("Goto Screen 3") {
                router.routeTo(AppRoute(routeInfo: AppRouteInfo.profileScreen3))
            }
            .navigationTitle("Profile Screen 2")
        }
    }
}
