//
//  MovieListPresenter.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol MovieListPresenting {
    func presentLoading()
    func hideLoading()
    func present(movieListResponse: MovieListResponse)
}

final class MovieListPresenter: MovieListPresenting {
    weak var viewController: MovieListDisplaying?
    
    func presentLoading() {
        viewController?.displayLoading()
        viewController?.startLoading()
    }
    
    func hideLoading() {
        viewController?.hideLoading()
        viewController?.stopLoading()
    }
    
    func present(movieListResponse: MovieListResponse) {
        viewController?.display(movieList: movieListResponse)
    }
}
