//
//  RouterView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 07/03/24.
//

import SwiftUI

//struct RouterView<Content: View>: View {
//    @StateObject var router: Router = Router()
//    // Our root view content
//    private let content: Content
//
//    init(@ViewBuilder content: @escaping () -> Content) {
//        self.content = content()
//    }
//
//    var body: some View {
//        NavigationStack(path: $router.path) {
//            content
//                .navigationDestination(for: Router.Route.self) { route in
//                    router.view(for: route)
//                }
//        }.tint(.orange)
//        .environmentObject(router)
//    }
//}

//class Router: ObservableObject {
//    // Define all the possible destinations being handled by the router here
//    enum Route: Hashable {
//        case movies
//        case movieDetails(Movie)
//        case movieReviews([Review])
//    }
//
//    // Programaticaly control our navigation stack
//    @Published var path: [Route] = []
//
//    // Builds the views here
//    @ViewBuilder func view(for route: Route) -> some View {
//        switch route {
//        case .movies:
//            MoviesView()
//        case .movieDetails(let movie):
//            MovieDetails(movie: movie)
//        case .movieReviews(let reviews):
//            MovieReviews(reviews: reviews)
//        }
//    }
//
//    /// Returns the first Route
//    /// - Returns: Route
//    func initialRoute() -> Route {
//        .movies
//    }
//
//    /// Navigate to another view
//    /// - Parameter route: route description
//    func push(_ route: Route) {
//        path.append(route)
//    }
//
//    /// Navigate to a series of views at once
//    /// - Parameter routes: routes description
//    func push(_ routes: [Route]) {
//        routes.forEach { route in
//            path.append(route)
//        }
//    }
//
//    /// Go back to the previous view
//    func pop() {
//        path.removeLast()
//    }
//
//    /// Pop to the root view in our hierarchy
//    func goToInitialRoute() {
//        path.removeLast(path.count)
//    }
//
//    /// Check if stack can pop a view
//    /// - Returns: can pop
//    func canPop() -> Bool {
//        !path.isEmpty
//    }
//
//    /// Pop till the given route
//    /// - Parameter route: route description
//    func popUntil(_ route: Route) {
//        for pathRoute in path {
//            if pathRoute == route {
//                break
//            } else {
//                path.removeLast()
//            }
//        }
//    }
//
//    /// Pop the top screen if possible then Push to the given route
//    /// - Parameter route: route to be pushed
//    func popAndPush(_ route: Route) {
//        if canPop() {
//            pop()
//        }
//        push(route)
//    }
//}
//

//public typealias Routable = View & Hashable
//
//public final class Router<Routes: Routable>: RoutableObject, ObservableObject {
//    public typealias Destination = Routes
//
//    @Published public var stack: [Routes] = []
//
//    public init() {}
//}
//

//
//extension RoutableObject {
//    /// Navigate to another view
//    /// - Parameter route: route description
//    public func push(_ route: Destination) {
//        stack.append(route)
//    }
//
//    /// Navigate to a series of views at once
//    /// - Parameter routes: routes description
//    public func push(_ routes: [Destination]) {
//        routes.forEach { route in
//            stack.append(route)
//        }
//    }
//
//    /// Go back to the previous view
//    public func pop() {
//        stack.removeLast()
//    }
//
//    /// Pop to the root view in our hierarchy
//    public func goToInitialRoute() {
//        stack.removeLast(stack.count)
//    }
//
//    /// Check if stack can pop a view
//    /// - Returns: can pop
//    public func canPop() -> Bool {
//        !stack.isEmpty
//    }
//
//    /// Pop till the given route
//    /// - Parameter route: route description
//    public func popUntil(_ route: Destination) {
//        for pathRoute in stack {
//            if pathRoute == route {
//                break
//            } else {
//                stack.removeLast()
//            }
//        }
//    }
//
//    /// Pop the top screen if possible then Push to the given route
//    /// - Parameter route: route to be pushed
//    public func popAndPush(_ route: Destination) {
//        if canPop() {
//            pop()
//        }
//        push(route)
//    }
//}
//



