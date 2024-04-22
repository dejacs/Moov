//
//  Coordinating.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get }
    var childCoordinators: [CoordinatorStartProtocol] { get }
    var currentCoordinator: CoordinatorStartProtocol? { get }
}

protocol CoordinatorStartProtocol {
    var outputDelegate: CoordinatorFinishDelegate? { get set }
    var responseDelegate: CoordinatorOutputDelegate? { get set }
    func start()
}

protocol CoordinatorFinishDelegate: AnyObject {
    func finish()
}

protocol CoordinatorOutputDelegate: AnyObject {
    func response<T>(_ response: T)
}
