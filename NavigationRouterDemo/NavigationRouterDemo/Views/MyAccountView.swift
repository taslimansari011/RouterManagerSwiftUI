//
//  MyAccountView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 19/03/24.
//

import SwiftUI

struct MyAccountView: View {
    @AppStorage("login") var login: Bool = false
    @EnvironmentObject var router: Router<AppRoutes>
    let listData = ["Profile", "Saved List", "My Reviews", "Logout"]
    var body: some View {
        List(listData, id: \.self) { data in
            HStack {
                Text(data)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .onTapGesture {
                if data == "Profile" {
                    router.routeTo(.profileScreen1)
                } else {
                    router.routeTo(.defaultScreen(message: data))
                }
            }
        }
        .navigationTitle("My Account")
        .toolbar {
            Button("Logout") {
                login = false
            }
        }
    }
}

struct ProfileScreen1: View {
    @EnvironmentObject var router: Router<AppRoutes>
    var body: some View {
        Button("Goto Screen 2") {
            router.routeTo(.profileScreen2)
        }
        .navigationTitle("ProfileScreen1")
    }
}

struct ProfileScreen2: View {
    @EnvironmentObject var router: Router<AppRoutes>
    var body: some View {
        Button("Goto Screen 3") {
            router.routeTo(.profileScreen3)
        }
        .navigationTitle("ProfileScreen2")
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
