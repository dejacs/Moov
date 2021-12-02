//
//  MovieDetailsPresenter.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol MovieDetailsPresenting {
    func presentLoading()
    func hideLoading()
}

final class MovieDetailsPresenter: MovieDetailsPresenting {
    weak var viewController: MovieDetailsDisplaying?
    
    func presentLoading() {
        viewController?.displayLoading()
        viewController?.startLoading()
    }
    
    func hideLoading() {
        viewController?.hideLoading()
        viewController?.stopLoading()
    }
}
