//
//  MovieListResponse+Fixture.swift
//  MoovTests
//
//  Created by Jade Silveira on 03/12/21.
//

import Foundation
@testable import Moov

extension MovieListResponse {
    static func fixture(
        page: Int = 1,
        results: [MovieResponse] = [.fixture()],
        totalPages: Int = 3,
        totalResults: Int = 54) -> MovieListResponse {
            .init(page: page,
                  results: results,
                  totalPages: totalPages,
                  totalResults: totalResults)
    }
}
