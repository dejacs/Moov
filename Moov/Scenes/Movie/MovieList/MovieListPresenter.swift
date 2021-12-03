//
//  MovieListPresenter.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol MovieListPresenting {
    func presentLoading()
    func hideLoading()
    func present(movieListResponse: MovieListResponse)
    func presentEmptyView()
    func presentErrorView()
    func presentErrorToast()
}

final class MovieListPresenter: MovieListPresenting {
    weak var viewController: MovieListDisplaying?
    
    func presentLoading() {
        viewController?.hideError()
        viewController?.hideEmpty()
        viewController?.hideMovieList()
        viewController?.displayLoading()
    }
    
    func hideLoading() {
        viewController?.hideLoading()
    }
    
    func present(movieListResponse: MovieListResponse) {
        viewController?.hideError()
        viewController?.hideEmpty()
        viewController?.hideLoading()
        viewController?.display(movieList: movieListResponse)
    }
    
    func presentEmptyView() {
        viewController?.hideError()
        viewController?.hideMovieList()
        viewController?.hideLoading()
        viewController?.displayEmpty()
    }
    
    func presentErrorView() {
        viewController?.hideEmpty()
        viewController?.hideMovieList()
        viewController?.hideLoading()
        viewController?.displayError()
    }
    
    func presentErrorToast() {
        viewController?.displayErrorToast()
    }
}
