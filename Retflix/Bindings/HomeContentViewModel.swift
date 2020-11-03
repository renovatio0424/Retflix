//
//  HomeContentViewModel.swift
//  Retflix
//
//  Created by RENO1 on 2020/11/03.
//

import SwiftUI
import Combine

//class HomeContentViewModel: ObservableObject {
//    
//    private var cancellable: AnyCancellable?
//    
//    @Published var movies: [Movie] = []
//    
//    @Published var featuredMovie: Movie?
//    
//    init() {
//        print("working...")
//        fetchMovies()
//    }
//    
//    private func fetchMovies(){
//        
//        self.cancellable = WebService().fetchMovies(endpoint: "watch/movie")
//            .sink(receiveCompletion: { (completionResult) in
//                print(completionResult)
//            }, receiveValue: {(listOfMovies: [Movie]) in
//                if listOfMovies.count > 0 {
//                        self.featuredMovie = listOfMovies.first
//                }
//                self.movies = listOfMovies
//                print(self.movies)
//            })
//    }
//    
//    
//}
