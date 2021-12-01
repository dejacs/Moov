//
//  MovieListInteractor.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol MovieListInteracting {
    
}

final class MovieListInteractor: MovieListInteracting {
    private let presenter: MovieListPresenting
    private let coordinator: MovieListCoordinating
    
    init(presenter: MovieListPresenting, coordinator: MovieListCoordinating) {
        self.presenter = presenter
        self.coordinator = coordinator
    }
}
