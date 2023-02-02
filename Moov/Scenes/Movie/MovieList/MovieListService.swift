//
//  MovieListService.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation
import NatworkSPM

protocol MovieListServicing {
    func fetchDailyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void)
    func fetchWeeklyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void)
    func search(movieText: String, page: Int, completion: @escaping (Result<MovieListResponse, ApiError>) -> Void)
}

final class MovieListService: MovieListServicing {
    private let network: NetworkCoreProtocol
    
    init(network: NetworkCoreProtocol) {
        self.network = network
    }
    
    func fetchDailyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        let endpoint: EndpointProtocol = TrendingDailyEndpoint()
        network.fetchDecodedDataWithURL(endpoint: endpoint,
                                        resultType: MovieListResponse.self,
                                        completion: completion)
    }
    
    func fetchWeeklyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        let endpoint: EndpointProtocol = TrendingWeeklyEndpoint()
        network.fetchDecodedDataWithURL(endpoint: endpoint,
                                        resultType: MovieListResponse.self,
                                        completion: completion)
    }
    
    func search(movieText: String, page: Int, completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        let endpoint: EndpointProtocol = SearchTextEndpoint(text: movieText, page: page.description)
        network.fetchDecodedDataWithURL(endpoint: endpoint,
                                        resultType: MovieListResponse.self,
                                        completion: completion)
    }
}
