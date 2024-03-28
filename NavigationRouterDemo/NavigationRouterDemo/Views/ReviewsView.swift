//
//  ReviewsView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 07/03/24.
//

import SwiftUI

struct MovieReviews: View {
    let reviews: [Review]
    @EnvironmentObject var router: Router<AppRoute>
        
    init(reviews: [Review]) {
        self.reviews = reviews
    }
    
    var body: some View {
        if reviews.isEmpty {
            Text("No reviews yet. Be the first to review.")
        } else {
            List(reviews, id: \.self) { review in
                Text(review.text).font(.headline)
            }
            .listStyle(.plain)
            .navigationTitle("Reviews")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Image(systemName: "house")
                    .foregroundColor(.orange)
                    .onTapGesture {
                        router.popToRoot()
                    }
            }
        }
    }
}

struct MovieReviews_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MovieReviews(reviews: MoviesDataProvider.buildData().first?.reviews ?? [])
                .navigationTitle("Reviews")
        }
    }
}
