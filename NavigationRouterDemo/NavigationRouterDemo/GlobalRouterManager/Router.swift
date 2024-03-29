//
//  Router.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 14/03/24.
//

import SwiftUI

public class Router<Destination: Routable>: ObservableObject, RoutingProtocols {
    /// Used to programatically control a navigation stack
    @Published public var stack: [Destination] = [] {
        didSet {
            currentPath = stack.map({ route in return route.routeInfo.path }).joined()
        }
    }
    public var currentPath: String = ""
    @Published public var selectedTab: Int?
    /// Used to present a view using a sheet
    @Published public var presentingSheet: Destination?
    /// Used to present a view using a full screen cover
    @Published public var presentingFullScreenCover: Destination?
    /// Used by presented Router instances to dismiss themselves
    @Published public var isPresented: Binding<Destination?>?
    public var isPresenting: Bool {
        presentingSheet != nil || presentingFullScreenCover != nil
    }
    
    public init(isPresented: Binding<Destination?> = .constant(nil)) {
        self.isPresented = isPresented
    }
    
    /// Returns the view associated with the specified `Routable`
    public func view(for route: Destination) -> some View {
        let router = router(routeType: route.navigationType)
        return route.viewToDisplay(router: router, route.navigationType)
    }
    
    /// Routes to the specified `Routable`.
    public func routeTo(_ route: Destination) {
        if route.isLoginRequired {
            guard route.isUserLoggedIn else {
                if let loginRoute = route.getLoginRoute() as? Destination {
                    presentSheet(loginRoute)
                }
                return
            }
        }
        switch route.navigationType {
        case .tab:
            selectedTab = route.routeInfo.tabIndex
        case .push:
            push(route)
        case .sheet:
            presentSheet(route)
        case .fullScreenCover:
            presentFullScreen(route)
        }
    }
    
    /// Navigate to a series of views at once
    /// - Parameter routes: routes description
    public func pushMultiple(_ routes: [Destination]) {
        routes.forEach { route in
            routeTo(route)
        }
    }
    
    /// Replace the stack with the given array of routes
    /// - Parameter routes: routes description
    public func pushReplacement(_ routes: [Destination]) {
        if routes.isEmpty {
            popToRoot()
        } else {
            stack = routes
        }
    }
    
    // Pop to the root screen in our hierarchy
    public func popToRoot() {
        stack.removeLast(stack.count)
    }
    
    // Dismisses presented screen or self
    public func dismiss() {
        if !stack.isEmpty {
            stack.removeLast()
        } else if let sheet = isPresented?.wrappedValue {
            sheet.onDismiss()
            isPresented?.wrappedValue = nil
        } else {
            presentingSheet?.onDismiss()
            isPresented?.wrappedValue = nil
        }
    }
    
    /// Dismiss the sheet
    public func dismissSheet() {
        isPresented?.wrappedValue?.onDismiss()
        isPresented?.wrappedValue = nil
    }
    
    /// Check if stack can pop a view
    /// - Returns: can pop
    public func canPop() -> Bool {
        !stack.isEmpty
    }
    
    /// Pop till the given route
    /// - Parameter route: route description
    public func popUntil(_ route: Destination) {
        for pathRoute in stack {
            if pathRoute == route {
                break
            } else {
                stack.removeLast()
            }
        }
    }
    
    /// Pop the top screen if possible then Push to the given route
    /// - Parameter route: route to be pushed
    public func popAndPush(_ route: Destination) {
        if canPop() {
            dismiss()
        }
        push(route)
    }
    
    private func push(_ appRoute: Destination) {
        stack.append(appRoute)
        currentPath.append(appRoute.routeInfo.path)
    }
    
    private func presentSheet(_ route: Destination) {
        self.presentingSheet = route
    }
    
    private func presentFullScreen(_ route: Destination) {
        self.presentingFullScreenCover = route
    }
    
    // Return the appropriate Router instance based
    // on `NavigationType`
    private func router(routeType: NavigationType) -> Router {
        switch routeType {
        case .push, .tab:
            return self
        case .sheet:
            return Router(
                isPresented: Binding(
                    get: { self.presentingSheet },
                    set: { self.presentingSheet = $0 }
                )
            )
        case .fullScreenCover:
            return Router(
                isPresented: Binding(
                    get: { self.presentingFullScreenCover },
                    set: { self.presentingFullScreenCover = $0 }
                )
            )
        }
    }
    
    public func handleDeeplink(routes: [Destination], isPathPresentInThisStack: Bool) {
        if isPathPresentInThisStack {
            if let index = stack.lastIndexOfContiguous(routes) {
                while stack.count > index + 1 {
                    stack.removeLast()
                }
            }
        } else {
            pushMultiple(routes)
        }
    }
    
    public func isPathPresent(path: String) -> Bool {
        currentPath.contains(path)
    }
}
