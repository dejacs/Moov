//
//  MovieResponse+Fixture.swift
//  MoovTests
//
//  Created by Jade Silveira on 03/12/21.
//

import Foundation
@testable import Moov

extension MovieResponse {
    static func fixture(id: Int = 617653,
                        posterPath: String? = "/zjrJE0fpzPvX8saJXj8VNfcjBoU.jpg",
                        title: String = "The Last Duel",
                        overview: String = "King Charles VI declares that Knight Jean de Carrouges settle his dispute with his squire, Jacques Le Gris, by challenging him to a duel.") -> MovieResponse {
        MovieResponse(id: id,
                      posterPath: posterPath,
                      title: title,
                      overview: overview)
    }
}
