//
//  MoviesView.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 07/03/24.
//

import SwiftUI
import MyRouteManager

struct MoviesView: View {
    @StateObject var router: Router<AppRoute>
    
    let movies: [Movie] = MoviesDataProvider.buildData()
    var body: some View {
        List(movies, id: \.self) { movie in
            MovieView(movie: movie, showMovieReviews: {
                router.pushMultiple([
                    AppRoute(routeInfo: AppRouteInfo.movieDetails(movie)),
                    AppRoute(routeInfo: AppRouteInfo.movieReviews(movie.reviews))
                ])
            })
            .onTapGesture {
                router.routeTo(AppRoute(routeInfo: AppRouteInfo.movieDetails(movie)))
            }
        }
        .listStyle(.plain)
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(router: Router())
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
