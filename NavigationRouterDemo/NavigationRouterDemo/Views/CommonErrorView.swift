//
//  CommonErrorView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 19/03/24.
//

import SwiftUI

struct CommonErrorView: View {
    let message: String
    var body: some View {
        if message.isEmpty {
            Text("Sorry, No screen found for th current route.")
        } else {
            Text(message)
        }
    }
}

struct CommonErrorView_Previews: PreviewProvider {
    static var previews: some View {
        CommonErrorView(message: "")
    }
}
