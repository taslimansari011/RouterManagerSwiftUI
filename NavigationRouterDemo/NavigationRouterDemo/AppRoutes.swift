//
//  AppRouter.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 14/03/24.
//

import SwiftUI

final class AppRoute: Routable {
    @AppStorage("login") var loggedIn: Bool = false
    var queryData: Any?
    var routeInfo: AppRouteInfo
    var navigationType: NavigationType
    var transition: AnyTransition?
    var onDismiss: ((Bool) -> Void)?
    
    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        lhs.routeInfo.path == rhs.routeInfo.path
    }
    
    required init(routeInfo: AppRouteInfo, navigationType: NavigationType = .push, queryData: Any = "", onDismiss: ((Bool) -> Void)? = nil) {
        self.routeInfo = routeInfo
        self.navigationType = navigationType
        self.onDismiss = onDismiss
        self.queryData = queryData
    }
    
    func getLoginRoute(onDismiss: Callback? = nil) -> any Routable {
        AppRoute(routeInfo: .login, navigationType: .sheet, onDismiss: onDismiss)
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
            if navigationType == .push {
                MovieReviews(reviews: reviews)
            } else {
                AnyView(RoutingView(router: router, AppRoute.self) {
                    MovieReviews(reviews: reviews)
                })
            }
        case .defaultScreen(let msg):
            CommonView(message: msg)
        case .myAccount:
            MyAccountView(router: router)
        case .profileScreen1:
            ProfileScreen1(router: router)
        case .profileScreen2(let data):
            let screenData = data
            ProfileScreen2(router: router, queryData: screenData)
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
    
    func isRouteValid(onDismiss: Callback?) -> (any Routable)? {
        switch routeInfo {
        case .profileScreen1, .profileScreen2, .profileScreen3:
            if loggedIn {
                return nil
            } else {
                return getLoginRoute(onDismiss: onDismiss)
            }
        default:
            return nil
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
    case profileScreen2(data: String)
    case profileScreen3
    case login
    
    init?(path: String, data: Any? = nil) {
        switch path.lowercased() {
        case "/", "movies":
            self = .home
        case "help":
            self = .help
        case "details":
            let movie = data as? Movie
            self = .movieDetails(movie)
        case "reviews":
            let movie = data as? Movie
            self = .movieReviews(movie?.reviews ?? [])
        case "myaccount":
            self = .myAccount
        case "commonscreen":
            self = .defaultScreen(message: "")
        case "profilescreen1":
            self = .profileScreen1
        case "profilescreen2":
            self = .profileScreen2(data: data as? String ?? "")
        case "profilescreen3":
            self = .profileScreen3
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
