//
//  AppRouter.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 14/03/24.
//

import SwiftUI

final class AppRoute: Routable {
    
    @AppStorage("login") var loggedIn: Bool = false
    var isUserLoggedIn: Bool {
        loggedIn
    }
    var routeInfo: AppRouteInfo
    var navigationType: NavigationType
    var transition: AnyTransition?
    var isLoginRequired: Bool = false
    var onDismiss: (() -> Void)
    
    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        lhs.routeInfo.path == rhs.routeInfo.path
    }
    
    required init(routeInfo: AppRouteInfo, navigationType: NavigationType = .push, isLoginRequired: Bool = false, onDismiss: @escaping () -> Void = {}) {
        self.routeInfo = routeInfo
        self.navigationType = navigationType
        self.isLoginRequired = isLoginRequired
        self.onDismiss = onDismiss
    }
    
    func getLoginRoute() -> any Routable {
        AppRoute(routeInfo: .login, navigationType: .sheet) {
            /// This will be called on dimissing the route
            print("Dismissed login")
        }
    }
    
    @ViewBuilder
    func viewToDisplay(router: Router<AppRoute>, _ navigtionType: NavigationType) -> some View {
        switch self.routeInfo {
        case .home:
            MoviesView(router: router)
        case .movieDetails(let movie):
            if let movie {
                MovieDetails(movie: movie, router: router)
            } else {
                CommonView(message: "No Movie data found")
            }
        case .movieReviews(let reviews):
            MovieReviews(reviews: reviews)
        case .defaultScreen(let msg):
            CommonView(message: msg)
        case .myAccount:
            MyAccountView(router: router)
        case .profileScreen1:
            ProfileScreen1(router: router)
        case .profileScreen2:
            ProfileScreen2(router: router)
        case .profileScreen3:
            CommonView(message: "Profile Screen 3")
        case .help:
            CommonView(message: "Help Screen")
        case .login:
            if navigtionType == .push {
                AnyView(LoginView(router: router))
            } else {
                AnyView(RoutingView(router: router, AppRoute.self) {
                    LoginView(router: router)
                })
            }
        }
    }
}

/// This file will be used to define all the possible routes in the app and there type of navigation eg. .sheet or .push
public enum AppRouteInfo: RouteInfo {
    case home
    case help
    case movieDetails(Movie?)
    case movieReviews([Review])
    case defaultScreen(message: String)
    case myAccount
    case profileScreen1
    case profileScreen2
    case profileScreen3
    case login
    
    public static func initWith(path: String, movie: Movie? = nil) -> AppRouteInfo? {
        switch path.lowercased() {
        case "/", "movies":
            return .home
        case "help":
            return .help
        case "details":
            return .movieDetails(movie)
        case "reviews":
            return .movieReviews(movie?.reviews ?? [])
        case "myaccount":
            return .myAccount
        case "commonscreen":
            return .defaultScreen(message: "")
        case "profilescreen1":
            return .profileScreen1
        case "profilescreen2":
            return .profileScreen2
        case "profilescreen3":
            return .profileScreen3
        default:
            return nil
        }
    }
    
    public var tabIndex: Int? {
        switch self {
        case .home:
            return 0
        case .help:
            return 1
        case .myAccount:
            return 2
        default:
            return nil
        }
    }
    
    public var path: String {
        switch self {
        case .home:
            return "/movies"
        case .movieDetails:
            return "/moviedetails"
        case .movieReviews:
            return "/reviews"
        case .myAccount:
            return "/myaccount"
        case .profileScreen1:
            return "/profilescreen1"
        case .profileScreen2:
            return "/profilescreen2"
        case .profileScreen3:
            return "/profilescreen3"
        case .login:
            return "/login"
        default:
            return "/commonscreen"
        }
    }
}
