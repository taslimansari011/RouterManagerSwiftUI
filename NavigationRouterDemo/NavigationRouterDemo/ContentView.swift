//
//  ContentView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 07/03/24.
//

import SwiftUI
import RouteManager

struct LoginView: View {
    @AppStorage("login") var login: Bool = false
    var body: some View {
        Button("Login") {
            login = true
        }
    }
}

enum Tab: Int, CaseIterable {
    case home
    case help
    case myAccount

    var title: String {
        switch self {
        case .home:
            return String(localized: "Movies")
        case .help:
            return String(localized: "Help")
        case .myAccount:
            return String(localized: "My Account")
        }
    }
    
    var systemImage: String {
        switch self {
        case .home:
            return String(localized: "house")
        case .help:
            return String(localized: "questionmark")
        case .myAccount:
            return String(localized: "person.fill")
        }
    }
}

struct AppTabbarView: View {
    @State var selectedTab = 0
//    @StateObject var homeRouter: Router<AppRoutes> = .init()
//    @StateObject var helpRouter = Router<AppRoutes>()
//    @StateObject var myAccountRouter = Router<AppRoutes>()
    @ObservedObject var tabRouter: TabRouter = TabRouter<AppRoutes>([
        Router(),Router(),Router()
    ])
    
    var body: some View {
        TabView(selection: $tabRouter.selectedTab) {
            RoutingView(router: tabRouter.navigationRouters[0], AppRoutes.self) {
                MoviesView()
            }
            .tabItem { Label(Tab.home.title, systemImage: Tab.home.systemImage) }
            .tag(0)
            
            RoutingView(router: tabRouter.navigationRouters[1], AppRoutes.self) {
                Text("Help")
            }
            .tabItem { Label(Tab.help.title, systemImage: Tab.help.systemImage) }
            .tag(1)
            
            RoutingView(router: tabRouter.navigationRouters[2], AppRoutes.self) {
                MyAccountView()
            }
            .tabItem { Label(Tab.myAccount.title, systemImage: Tab.myAccount.systemImage) }
            .tag(2)
        }
        .tint(.orange)
        .onOpenURL { url in
            openURL(url: url)
        }
    }
    
    private func openURL(url: URL) {
        let routes = url.pathComponents.compactMap { component in
            AppRoutes.initWith(path: component)
        }
        tabRouter.routeTo(tab: routes.first?.tabIndex ?? tabRouter.selectedTab, internalPath: routes)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabbarView()
    }
}

//var movieId = 0
//let queryItems = URLComponents(string: url.absoluteString)?.queryItems
//if let id = queryItems?.first(where: { $0.name == "id" })?.value, let value = Int(id) {
//    movieId = value
//}
//let movie = MoviesDataProvider.moviesWith(id: movieId)
