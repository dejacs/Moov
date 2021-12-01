//
//  MovieListPresenter.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol MovieListPresenting {
    
}

final class MovieListPresenter: MovieListPresenting {
    weak var viewController: MovieListDisplaying?
}
