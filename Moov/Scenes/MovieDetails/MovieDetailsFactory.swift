//
//  MovieDetailsFactory.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

enum MovieDetailsFactory {
    static func make(coordinator: MovieDetailsCoordinating) -> UIViewController {
        let presenter = MovieDetailsPresenter()
        let service = MovieDetailsService(network: Network())
        let interactor = MovieDetailsInteractor(presenter: presenter, coordinator: coordinator, service: service, movieId: 617653)
        let viewController = MovieDetailsViewController(interactor: interactor)
        
        presenter.viewController = viewController
        return viewController
    }
}
