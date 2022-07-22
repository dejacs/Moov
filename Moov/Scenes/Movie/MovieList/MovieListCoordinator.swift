//
//  MovieListCoordinator.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol MovieListCoordinating {
    func navigateToMovieDetails(movieId: Int)
}

final class MovieListCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators = [CoordinatorStartProtocol]()
    var currentCoordinator: CoordinatorStartProtocol?

    weak var outputDelegate: CoordinatorFinishDelegate?
    weak var responseDelegate: CoordinatorOutputDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MovieListCoordinator: CoordinatorStartProtocol {
    func start() {
        let viewController = MovieListFactory.make(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MovieListCoordinator: MovieListCoordinating {
    func navigateToMovieDetails(movieId: Int) {
        currentCoordinator = MovieDetailsCoordinator(
            navigationController: navigationController,
            movieId: movieId)
        
        currentCoordinator?.outputDelegate = self
        currentCoordinator?.responseDelegate = self
        
        childCoordinators.append(currentCoordinator)
        currentCoordinator?.start()
    }
    
    func finish() {
        outputDelegate?.finish()
    }
}

extension MovieListCoordinator: CoordinatorFinishDelegate {
    func finish<T>(_ response: T?) {
        childCoordinators.removeLast()
        currentCoordinator = childCoordinators.last
    }
}

extension MovieListCoordinator: CoordinatorOutputDelegate {
    func response<T>(_ response: T) {
        print(response)
    }
}
