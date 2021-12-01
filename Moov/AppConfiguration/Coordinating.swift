//
//  Coordinating.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol Coordinating {
    var childCoordinators: [Coordinating] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
