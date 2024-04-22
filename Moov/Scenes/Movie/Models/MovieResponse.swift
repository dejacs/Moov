//
//  MovieResponse.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation

struct MovieResponse: Decodable, Equatable {
    let id: Int
    let posterPath: String?
    let title: String
    let overview: String
}
