//
//  MovieDetailsInteractor.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol MovieDetailsInteracting {
    
}

final class MovieDetailsInteractor: MovieDetailsInteracting {
    private let presenter: MovieDetailsPresenting
    private let coordinator: MovieDetailsCoordinating
    
    init(presenter: MovieDetailsPresenting, coordinator: MovieDetailsCoordinating) {
        self.presenter = presenter
        self.coordinator = coordinator
    }
}
