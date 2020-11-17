//
//  MovieSearchView.swift
//  Retflix
//
//  Created by RENO1 on 2020/11/17.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchViewModel = MovieSearchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchViewModel.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: self.movieSearchViewModel.isLoading, error: self.movieSearchViewModel.error) {
                    self.movieSearchViewModel.search(query: self.movieSearchViewModel.query)
                }
                
                if self.movieSearchViewModel.movies != nil {
                    ForEach(self.movieSearchViewModel.movies!) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                Text(movie.yearText)
                            }
                        }
                    }
                }
                
            }
            .onAppear {
                self.movieSearchViewModel.startObserve()
            }
            .navigationBarTitle("Search")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
