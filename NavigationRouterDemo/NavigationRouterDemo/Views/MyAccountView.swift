//
//  MyAccountView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 19/03/24.
//

import SwiftUI
import MyRouteManager

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
