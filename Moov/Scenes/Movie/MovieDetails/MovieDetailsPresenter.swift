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
    func presentEmptyView()
    func presentErrorView()
    func present(movie: MovieResponse)
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
    
    func presentEmptyView() {
        
    }
    
    func presentErrorView() {
        
    }
    
    func present(movie: MovieResponse) {
        viewController?.display(movie: movie)
    }
}
