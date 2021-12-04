//
//  MovieDetailsPresenter.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol MovieDetailsPresenting {
    func presentLoading()
    func hideLoading()
    func presentErrorView()
    func present(movie: MovieResponse)
}

final class MovieDetailsPresenter: MovieDetailsPresenting {
    weak var viewController: MovieDetailsDisplaying?
    
    func presentLoading() {
        viewController?.hideError()
        viewController?.hideMovie()
        viewController?.displayLoading()
    }
    
    func hideLoading() {
        viewController?.hideLoading()
    }
    
    func present(movie: MovieResponse) {
        viewController?.display(movie: movie)
        viewController?.hideError()
        viewController?.hideLoading()
    }
    
    func presentErrorView() {
        viewController?.hideMovie()
        viewController?.hideLoading()
        viewController?.displayError()
    }
}
