//
//  MovieDetailsCoordinator.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol MovieDetailsCoordinating {
    func finish()
}

final class MovieDetailsCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators = [CoordinatorStartProtocol]()
    var currentCoordinator: CoordinatorStartProtocol?
    
    weak var outputDelegate: CoordinatorFinishDelegate?
    weak var responseDelegate: CoordinatorOutputDelegate?
    
    private let movieId: Int

    init(navigationController: UINavigationController, movieId: Int) {
        self.navigationController = navigationController
        self.movieId = movieId
    }
}

extension MovieDetailsCoordinator: CoordinatorStartProtocol {
    func start() {
        let viewController = MovieDetailsFactory.make(coordinator: self, movieId: movieId)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MovieDetailsCoordinator: MovieDetailsCoordinating {
    func finish() {
        responseDelegate?.response("TESTE DE RESPONSE")
        outputDelegate?.finish()
    }
}
