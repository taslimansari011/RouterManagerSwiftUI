//
//  RoutingView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 14/03/24.
//

import SwiftUI

public struct RoutingView<Content: View, Destination: Routable>: View {
    @ObservedObject private var router: Router<Destination>
    private let rootContent: () -> Content

    public init(router: Router<Destination>, _ routeType: Destination.Type, @ViewBuilder content: @escaping () -> Content) {
        self.router = router
        rootContent = content
    }
    
    public var body: some View {
        NavigationStack(path: $router.stack) {
            rootContent()
                .navigationDestination(for: Destination.self) { route in
                    router.view(for: route)
                }
        }
        .sheet(item: $router.presentingSheet) { route in
            router.view(for: route)
        }
        .fullScreenCover(item: $router.presentingFullScreenCover) { route in
            router.view(for: route)
        }
        .environmentObject(router)
    }
}
