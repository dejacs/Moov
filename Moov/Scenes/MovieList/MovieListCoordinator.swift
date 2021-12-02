//
//  MovieListCoordinator.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol MovieListCoordinating: Coordinating {
    func navigateToMovieDetails(movieId: Int)
}

final class MovieListCoordinator: MovieListCoordinating {
    var childCoordinators = [Coordinating]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MovieListFactory.make(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToMovieDetails(movieId: Int) {
        let coordinator = MovieDetailsCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
