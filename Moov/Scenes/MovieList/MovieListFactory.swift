//
//  MovieListFactory.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

enum MovieListFactory {
    static func make(coordinator: MovieListCoordinating) -> UIViewController {
        let presenter = MovieListPresenter()
        let interactor = MovieListInteractor(presenter: presenter, coordinator: coordinator)
        let viewController = MovieListViewController(interactor: interactor)
        
        presenter.viewController = viewController
        return viewController
    }
}
