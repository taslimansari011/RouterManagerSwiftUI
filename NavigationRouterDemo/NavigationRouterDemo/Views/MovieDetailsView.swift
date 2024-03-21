//
//  MovieDetailsView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 07/03/24.
//

import SwiftUI
import RouteManager

struct MovieDetails: View {
    let movie: Movie
    @EnvironmentObject var router: Router<AppRoutes>
        
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        VStack {
            Image(movie.imageName)
                .resizable()
            VStack {
                HStack {
                    Text("About the movie:")
                        .foregroundColor(.orange)
                        .italic()
                        .underline()
                    Spacer()
                }
                Text(movie.description)
                    .font(.title3)
                Button {
                    router.routeTo(.movieReviews(movie.reviews))
                } label: {
                    Text("See All Reviews")
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }.padding(.horizontal)
        }
        .navigationTitle(movie.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MovieDetails(movie: MoviesDataProvider.buildData().first!)
        }
    }
}
