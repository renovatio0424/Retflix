//
//  MovieListView.swift
//  Retflix
//
//  Created by RENO1 on 2020/11/02.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieViewModel()
    @ObservedObject private var upcomingState = MovieViewModel()
    @ObservedObject private var topRatedState = MovieViewModel()
    @ObservedObject private var popularState = MovieViewModel()
    
    fileprivate func buildPosterView(title: String, viewModel: MovieViewModel, endPoint: MovieListEndPoint) -> some View {
        return Group {
            if nowPlayingState.movies != nil {
                MoviePosterCarouselView(title: title, movies: viewModel.movies!)
            } else {
                LoadingView(isLoading: viewModel.isLoading, error: viewModel.error) {
                    viewModel.loadMovies(with: endPoint)
                }
            }
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
    }
    
    
    fileprivate func buildCardView(title: String, viewModel: MovieViewModel, endPoint: MovieListEndPoint) -> some View {
        return Group {
            if upcomingState.movies != nil {
                MovieBackdropCarouselView(title: title, movies: viewModel.movies!)
            } else {
                LoadingView(isLoading: viewModel.isLoading, error: viewModel.error) {
                    viewModel.loadMovies(with: endPoint)
                }
            }
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
    
    var body: some View {
        NavigationView {
            List {
                buildPosterView(title: "Now Playing", viewModel: nowPlayingState, endPoint: .nowPlaying)
                
                buildCardView(title: "Upcoming", viewModel: upcomingState, endPoint: .upcoming)
                
                buildCardView(title: "Top Rated", viewModel: topRatedState, endPoint: .topRated)
                
                buildCardView(title: "Popular", viewModel: popularState, endPoint: .popular)
            }
            .navigationTitle("Retflix")
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.upcomingState.loadMovies(with: .upcoming)
            self.topRatedState.loadMovies(with: .topRated)
            self.popularState.loadMovies(with: .popular)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
