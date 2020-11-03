//
//  MovieListView.swift
//  Retflix
//
//  Created by RENO1 on 2020/11/02.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    if nowPlayingState.movies != nil {
                        MoviePosterCarouselView(title: "Now Playing", movies: nowPlayingState.movies!)
                    } else {
                        LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if upcomingState.movies != nil {
                        MovieBackdropCarouselView(title: "Upcoming", movies: upcomingState.movies!)
                    } else {
                        LoadingView(isLoading: nowPlayingState.isLoading, error: upcomingState.error) {
                            self.nowPlayingState.loadMovies(with: .upcoming)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if topRatedState.movies != nil {
                        MovieBackdropCarouselView(title: "Top Rated", movies: topRatedState.movies!)
                    } else {
                        LoadingView(isLoading: nowPlayingState.isLoading, error: topRatedState.error) {
                            self.nowPlayingState.loadMovies(with: .topRated)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if popularState.movies != nil {
                        MovieBackdropCarouselView(title: "Popular", movies: popularState.movies!)
                    } else {
                        LoadingView(isLoading: nowPlayingState.isLoading, error: popularState.error) {
                            self.nowPlayingState.loadMovies(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
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
