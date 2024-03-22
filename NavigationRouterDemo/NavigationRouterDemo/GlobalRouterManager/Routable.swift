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

public protocol Routable: Hashable, Identifiable {
    associatedtype ViewType: View
    var navigationType: NavigationType { get }
    var tabIndex: Int? { get }
    var path: String { get }
    func viewToDisplay() -> ViewType
}

extension Routable {
    public var id: Self { self }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
