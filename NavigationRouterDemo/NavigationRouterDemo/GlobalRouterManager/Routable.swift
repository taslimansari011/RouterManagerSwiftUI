//
//  Routable.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 14/03/24.
//

import SwiftUI

public enum NavigationType {
    case push
    case sheet
    case fullScreenCover
}

public protocol Routable: Hashable, Identifiable {
    associatedtype ViewType: View
    var navigationType: NavigationType { get }
    func viewToDisplay() -> ViewType
}

extension Routable {
    public var id: Self { self }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
