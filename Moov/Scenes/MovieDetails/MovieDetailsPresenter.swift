//
//  MovieDetailsPresenter.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol MovieDetailsPresenting {
    
}

final class MovieDetailsPresenter: MovieDetailsPresenting {
    weak var viewController: MovieDetailsDisplaying?
}
