//
//  MovieListResponse.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

struct MovieListResponse: Decodable, Equatable {
    let page: Int
    let results: [MovieResponse]
    let totalPages: Int
    let totalResults: Int
}
