//
//  MovieDetailsFactory.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit
import NetworkCore

enum MovieDetailsFactory {
    static func make(coordinator: MovieDetailsCoordinating, movieId: Int) -> UIViewController {
        let presenter = MovieDetailsPresenter()
        let service: MovieDetailsServicing = CommandLine.arguments.contains("--uitesting") ? MovieDetailsServiceMock() : MovieDetailsService(network: Network())
        let interactor = MovieDetailsInteractor(presenter: presenter, coordinator: coordinator, service: service, movieId: movieId)
        let viewController = MovieDetailsViewController(interactor: interactor)
        
        presenter.viewController = viewController
        return viewController
    }
}
