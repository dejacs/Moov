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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MovieDetailsFactory.make(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
