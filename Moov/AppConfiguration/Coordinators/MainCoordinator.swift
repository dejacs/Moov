//
//  MainCoordinator.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

final class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators = [CoordinatorStartProtocol]()
    var currentCoordinator: CoordinatorStartProtocol?

    weak var outputDelegate: CoordinatorFinishDelegate?
    weak var responseDelegate: CoordinatorOutputDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func finish() {
        outputDelegate?.finish()
    }
}

extension MainCoordinator: CoordinatorStartProtocol {
    func start() {
        currentCoordinator = MovieListCoordinator(navigationController: navigationController)
        currentCoordinator?.outputDelegate = self
        childCoordinators.append(currentCoordinator)
        currentCoordinator?.start()
    }
}

extension MainCoordinator: CoordinatorFinishDelegate {
    func finish<T>(_ response: T?) {
        childCoordinators.removeLast()
        currentCoordinator = childCoordinators.last
    }
}
