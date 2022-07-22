//
//  MovieDetailsServiceMock.swift
//  Moov
//
//  Created by Jade Silveira on 04/12/21.
//

import NatworkSPM
import UIKit

final class MovieDetailsServiceMock: MovieDetailsServicing {
    func search(movieId: Int, completion: @escaping (Result<MovieResponse, ApiError>) -> Void) {
        let asset = NSDataAsset(name: "json_successful_movie_details", bundle: Bundle.main)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(MovieResponse.self, from: asset!.data)
            completion(.success(response))
        } catch { completion(.failure(.generic)) }
    }
}

