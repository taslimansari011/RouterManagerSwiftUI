//
//  AppRouter.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 14/03/24.
//

import SwiftUI
import RouteManager

/// This file will be used to define all the possible routes in the app and there type of navigation eg. .sheet or .push
public enum AppRoutes: Routable {
    case movies
    case movieDetails(Movie?)
    case movieReviews([Review])
    case defaultScreen(message: String)
    case myAccount
    case profileScreen1
    case profileScreen2
    case profileScreen3
    
    static func initWith(path: String, movie: Movie? = nil) -> AppRoutes? {
        switch path.lowercased() {
        case "movies":
            return .movies
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
    
    public var tabIndex: Int {
        switch self {
        case .movies:
            return 0
        case .myAccount:
            return 2
        default:
            return 0
        }
    }
    
    @ViewBuilder
    public func viewToDisplay() -> some View {
        switch self {
        case .movies:
            MoviesView()
        case .movieDetails(let movie):
            if let movie {
                MovieDetails(movie: movie)
            } else {
                CommonErrorView(message: "No Movie data found")
            }
        case .movieReviews(let reviews):
            MovieReviews(reviews: reviews)
        case .defaultScreen(let msg):
            CommonErrorView(message: msg)
        case .myAccount:
            MyAccountView()
        case .profileScreen1:
            ProfileScreen1()
        case .profileScreen2:
            ProfileScreen2()
        case .profileScreen3:
            CommonErrorView(message: "Profile Screen 3")
        }
    }
    
    public var navigationType: NavigationType {
        switch self {
        case .movieDetails, .defaultScreen:
            return .push
        case .movies, .myAccount:
            return .tab
        case .movieReviews:
            return .sheet
        case .profileScreen1, .profileScreen2, .profileScreen3:
            return .push
        }
    }
}
