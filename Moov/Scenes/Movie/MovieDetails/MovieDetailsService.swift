//
//  MovieDetailsService.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation
import NatworkSPM

protocol MovieDetailsServicing {
    func search(movieId: Int, completion: @escaping (Result<MovieResponse, ApiError>) -> Void)
}

final class MovieDetailsService: MovieDetailsServicing {
    private let network: NetworkCoreProtocol
    
    init(network: NetworkCoreProtocol) {
        self.network = network
    }
    
    func search(movieId: Int, completion: @escaping (Result<MovieResponse, ApiError>) -> Void) {
        let endpoint: EndpointProtocol = MovieSearchIdEndpoint(id: movieId.description)
        network.fetchDecodedDataWithURL(endpoint: endpoint, resultType: MovieResponse.self, completion: completion)
    }
}
