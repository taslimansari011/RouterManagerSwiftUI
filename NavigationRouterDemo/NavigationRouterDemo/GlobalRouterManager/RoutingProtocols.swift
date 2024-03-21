//
//  RoutingProtocols.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 14/03/24.
//

import Foundation

public protocol RoutingProtocols: AnyObject {
    associatedtype Destination: Routable
    /// An array representing the current navigation stack of destinations.
    /// Modifying this stack updates the navigation state of the application.
    var stack: [Destination] { get set }
    /// Navigate to a series of views at once
    /// - Parameter routes: routes description
    func routeTo(_ route: Destination)
    /// Navigate to a series of views at once
    /// - Parameter routes: routes description
    func pushMultiple(_ routes: [Destination])
    /// Pop to the root view in our hierarchy
    func popToRoot()
    /// Go back to the previous view
    func dismiss()
    /// Check if stack can pop a view
    /// - Returns: can pop
    func canPop() -> Bool
    /// Pop till the given route
    /// - Parameter route: route description
    func popUntil(_ route: Destination)
    /// Pop the top screen if possible then Push to the given route
    /// - Parameter route: route to be pushed
    func popAndPush(_ route: Destination)
}
