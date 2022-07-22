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
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func search(movieId: Int, completion: @escaping (Result<MovieResponse, ApiError>) -> Void) {
        network.fetchData(urlText: MovieEndpoint.searchMovieId(movieId).urlText,
            resultType: MovieResponse.self,
            decodingStrategy: .convertFromSnakeCase,
            completion: completion)
    }
}
