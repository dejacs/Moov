//
//  MovieDetailsInteractor.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol MovieDetailsInteracting {
    func fetchMovieDetails()
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
        self.presenter.presentLoading()
        
        service.search(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            self.presenter.hideLoading()
            
            switch result {
            case .success(let movie):
                print("success")
            case .failure:
                print("failure")
            }
        }
    }
}
