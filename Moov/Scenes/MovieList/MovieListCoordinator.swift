//
//  MovieListCoordinator.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol MovieListCoordinating: Coordinating {
    
}

final class MovieListCoordinator: MovieListCoordinating {
    var childCoordinators = [Coordinating]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MovieListFactory.make(coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}
