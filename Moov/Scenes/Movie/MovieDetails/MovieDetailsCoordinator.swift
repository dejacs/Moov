//
//  MovieDetailsCoordinator.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol MovieDetailsCoordinating: Coordinating {
    
}

final class MovieDetailsCoordinator: MovieDetailsCoordinating {
    var childCoordinators = [Coordinating]()
    var navigationController: UINavigationController
    
    private let movieId: Int

    init(navigationController: UINavigationController, movieId: Int) {
        self.navigationController = navigationController
        self.movieId = movieId
    }

    func start() {
        let viewController = MovieDetailsFactory.make(coordinator: self, movieId: movieId)
        navigationController.pushViewController(viewController, animated: true)
    }
}
