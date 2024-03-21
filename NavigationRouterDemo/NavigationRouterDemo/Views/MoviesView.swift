//
//  MoviesView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 07/03/24.
//

import SwiftUI
import RouteManager

struct MoviesView: View {
    @EnvironmentObject var router: Router<AppRoutes>
    
    let movies: [Movie] = MoviesDataProvider.buildData()
    var body: some View {
        List(movies, id: \.self) { movie in
            MovieView(movie: movie, showMovieReviews: {
                router.pushMultiple([.movieDetails(movie), .movieReviews(movie.reviews)])
            })
            .onTapGesture {
                router.routeTo(.movieDetails(movie))
            }
        }
        .listStyle(.plain)
    }
    
    private func openURL(url: URL) {
        var movieId = 0
        let queryItems = URLComponents(string: url.absoluteString)?.queryItems
        if let id = queryItems?.first(where: { $0.name == "id" })?.value, let value = Int(id) {
            movieId = value
        }
        let movie = MoviesDataProvider.moviesWith(id: movieId)
        let routes = url.pathComponents.compactMap { component in
            AppRoutes.initWith(path: component, movie: movie)
        }
        router.pushMultiple(routes)
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
            .navigationTitle("Movies")
    }
}

struct MovieView: View {
    let movie: Movie
    let showMovieReviews: () -> Void
    
    var iconView: some View {
        Image(movie.imageName)
            .resizable()
            .frame(width: 60, height: 120)
            .scaledToFill()
            .bold()
    }
    
    var ratingsView: some View {
        HStack {
            Image(systemName: "star.fill").foregroundColor(.yellow)
            Text(String(movie.rating)).bold()
            Text(String(movie.year)).foregroundColor(.secondary)
            Text(String(movie.runtime))
                .foregroundColor(.secondary)
                .font(.callout)
        }
    }
    
    var detailsView: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(movie.name)
                .foregroundColor(.orange)
                .font(.title2).italic()
                .onTapGesture {
                    print(movie.name)
                }
            Text(movie.description).font(.caption).lineLimit(2)
            ratingsView
            Button {
                showMovieReviews()
            } label: {
                Text("See All Reviews")
                    .frame(height: 10)
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            iconView
            detailsView
            Spacer()
        }
        .navigationTitle("Movies")
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: MoviesDataProvider.buildData().first!) {}
    }
}
