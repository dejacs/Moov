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
        let interactor = MovieDetailsInteractor(presenter: presenter, coordinator: coordinator)
        let viewController = MovieDetailsViewController(interactor: interactor)
        
        presenter.viewController = viewController
        return viewController
    }
}
