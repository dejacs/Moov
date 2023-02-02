//
//  MovieListFactory.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import NatworkSPM
import UIKit

enum MovieListFactory {
    static func make(coordinator: MovieListCoordinating) -> UIViewController {
        let presenter = MovieListPresenter()
        let service: MovieListServicing = CommandLine.arguments.contains("--uitesting") ? MovieListServiceMock() : MovieListService(network: NetworkCore())
        let interactor = MovieListInteractor(presenter: presenter, coordinator: coordinator, service: service)
        let viewController = MovieListViewController(interactor: interactor)
        
        presenter.viewController = viewController
        return viewController
    }
}
