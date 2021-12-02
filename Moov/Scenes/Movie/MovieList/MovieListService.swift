//
//  MovieListService.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation
import NetworkCore

protocol MovieListServicing {
    func fetchDailyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void)
    func fetchWeeklyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void)
    func search(movieText: String, completion: @escaping (Result<MovieListResponse, ApiError>) -> Void)
}

final class MovieListService: MovieListServicing {
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func fetchDailyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        network.fetchData(with: MovieEndpoint.trendingDaily,
            resultType: MovieListResponse.self,
            decodingStrategy: .convertFromSnakeCase,
            completion: completion)
    }
    
    func fetchWeeklyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        network.fetchData(with: MovieEndpoint.trendingWeekly,
            resultType: MovieListResponse.self,
            decodingStrategy: .convertFromSnakeCase,
            completion: completion)
    }
    
    func search(movieText: String, completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        network.fetchData(with: MovieEndpoint.searchText(movieText),
            resultType: MovieListResponse.self,
            decodingStrategy: .convertFromSnakeCase,
            completion: completion)
    }
}
