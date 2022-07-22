//
//  MovieDetailsInteractor.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation

protocol MovieDetailsInteracting {
    func fetchMovieDetails()
    func finish()
}

final class MovieDetailsInteractor: MovieDetailsInteracting {
    private let presenter: MovieDetailsPresenting
    private let coordinator: MovieDetailsCoordinating
    private let service: MovieDetailsServicing
    private let movieId: Int
    
    init(presenter: MovieDetailsPresenting, coordinator: MovieDetailsCoordinating, service: MovieDetailsServicing, movieId: Int) {
        self.presenter = presenter
        self.coordinator = coordinator
        self.service = service
        self.movieId = movieId
    }
    
    func fetchMovieDetails() {
        presenter.presentLoading()
        
        service.search(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            self.presenter.hideLoading()
            
            switch result {
            case .success(let movie):
                self.presenter.present(movie: movie)
            case .failure:
                self.presenter.presentErrorView()
            }
        }
    }
    
    func finish() {
        coordinator.finish()
    }
}
