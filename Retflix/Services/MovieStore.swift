//
//  MovieStore.swift
//  Retflix
//
//  Created by RENO1 on 2020/11/02.
//

import Foundation

class MovieStore: MovieService {
    static let shared = MovieStore()
    
    private init() {}
    
    private let apiKey = "2d63e91bf67a844d7af38e30b29c2b6e"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard  let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard  let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, params: ["append_to_response" : "videos,credits"], completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard  let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language" : "en-US",
            "include_adult":"false",
            "region":"US",
            "query":query
        ], completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        // weak self ?
        // resume ??
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                self.executeCompletionHandlerMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerMainThread<D: Decodable> (with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
