//
//  AppRouter.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 14/03/24.
//

import SwiftUI

/// This file will be used to define all the possible routes in the app and there type of navigation eg. .sheet or .push
public enum AppRoutes: Routable {
    case home
    case help
    case movieDetails(Movie?)
    case movieReviews([Review])
    case defaultScreen(message: String)
    case myAccount
    case profileScreen1
    case profileScreen2
    case profileScreen3
    
    public static func initWith(path: String, movie: Movie? = nil) -> AppRoutes? {
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
    
    @ViewBuilder
    public func viewToDisplay() -> some View {
        switch self {
        case .home:
            MoviesView()
        case .movieDetails(let movie):
            if let movie {
                MovieDetails(movie: movie)
            } else {
                CommonView(message: "No Movie data found")
            }
        case .movieReviews(let reviews):
            MovieReviews(reviews: reviews)
        case .defaultScreen(let msg):
            CommonView(message: msg)
        case .myAccount:
            MyAccountView()
        case .profileScreen1:
            ProfileScreen1()
        case .profileScreen2:
            ProfileScreen2()
        case .profileScreen3:
            CommonView(message: "Profile Screen 3")
        case .help:
            CommonView(message: "Help Screen")
        }
    }
    
    public var navigationType: NavigationType {
        switch self {
        case .movieDetails, .defaultScreen:
            return .push
        case .home, .help, .myAccount:
            return .tab
        case .movieReviews:
            return .sheet
        case .profileScreen1, .profileScreen2, .profileScreen3:
            return .push
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
        default:
            return "/commonscreen"
        }
    }
}
