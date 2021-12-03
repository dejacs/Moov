//
//  SearchControl.swift
//  Moov
//
//  Created by Jade Silveira on 02/12/21.
//

struct SearchControl {
    let text: String
    var page = 1
    let totalPages: Int
}

extension SearchControl {
    init(text: String, movieList: MovieListResponse) {
        self.text = text
        page = movieList.page
        totalPages = movieList.totalPages
    }
}
