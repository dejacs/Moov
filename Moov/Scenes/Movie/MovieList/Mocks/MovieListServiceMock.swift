//
//  MovieListServiceMock.swift
//  Moov
//
//  Created by Jade Silveira on 04/12/21.
//

import NatworkSPM
import UIKit

final class MovieListServiceMock: MovieListServicing {
    func fetchDailyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        let asset = NSDataAsset(name: "json_successful_search", bundle: Bundle.main)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(MovieListResponse.self, from: asset!.data)
            completion(.success(response))
        } catch { completion(.failure(.generic)) }
    }
    
    func fetchWeeklyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        let asset = NSDataAsset(name: "json_successful_search", bundle: Bundle.main)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(MovieListResponse.self, from: asset!.data)
            completion(.success(response))
        } catch { completion(.failure(.generic)) }
    }
    
    func search(movieText: String, page: Int, completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        let asset = NSDataAsset(name: "json_successful_search_text", bundle: Bundle.main)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(MovieListResponse.self, from: asset!.data)
            completion(.success(response))
        } catch { completion(.failure(.generic)) }
    }
}
