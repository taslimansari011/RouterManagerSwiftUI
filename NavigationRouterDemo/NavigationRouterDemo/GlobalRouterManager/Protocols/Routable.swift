//
//  Routable.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 14/03/24.
//

import SwiftUI

public enum NavigationType {
    case tab
    case push
    case sheet
    case fullScreenCover
}

public protocol RouteInfo: Hashable {
    var tabIndex: Int? { get }
    var path: String { get }
}

public protocol Routable: Hashable, Identifiable {
    associatedtype ViewType: View
    associatedtype T: RouteInfo
    var routeInfo: T { get set }
    var navigationType: NavigationType { get set }
    var transition: AnyTransition? { get set }
    var isLoginRequired: Bool { get }
    var isUserLoggedIn: Bool { get }
    var onDismiss: (() -> Void) { get set }
    func getLoginRoute() -> any Routable
    func viewToDisplay(router: Router<Self>, _ navigtionType: NavigationType) -> ViewType
    
    init(routeInfo: T, navigationType: NavigationType, isLoginRequired: Bool, onDismiss: @escaping () -> Void)
}

extension Routable {
    public var id: Self { self }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
