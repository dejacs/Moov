//
//  MovieDetailsInteractorTests.swift
//  MoovTests
//
//  Created by Jade Silveira on 04/12/21.
//

import NatworkSPM
import XCTest
@testable import Moov

private final class MovieDetailsPresenterSpy: MovieDetailsPresenting {
    private(set) var presentLoadingCallsCount = 0
    private(set) var hideLoadingCallsCount = 0
    private(set) var presentMovieCallsCount = 0
    private(set) var presentErrorViewCallsCount = 0
    
    private(set) var presentMovieReceivedInvocation: MovieResponse?
    
    func presentLoading() {
        presentLoadingCallsCount += 1
    }
    
    func hideLoading() {
        hideLoadingCallsCount += 1
    }
    
    func presentErrorView() {
        presentErrorViewCallsCount += 1
    }
    
    func present(movie: MovieResponse) {
        presentMovieCallsCount += 1
        presentMovieReceivedInvocation = movie
    }
}

private final class MovieDetailsCoordinatorSpy: MovieDetailsCoordinating {
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    private(set) var startCallsCount = 0
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startCallsCount += 1
    }
}

private final class MovieDetailsServiceMock: MovieDetailsServicing {
    var searchMovieIdExpectedResult: Result<MovieResponse, ApiError>?
    
    func search(movieId: Int, completion: @escaping (Result<MovieResponse, ApiError>) -> Void) {
        guard let expectedResult = searchMovieIdExpectedResult else {
            XCTFail("Expected result was not defined.")
            return
        }
        completion(expectedResult)
    }
}

final class MovieDetailsInteractorTests: XCTestCase {
    private let presenterSpy = MovieDetailsPresenterSpy()
    private let serviceMock = MovieDetailsServiceMock()
    private lazy var coordinatorSpy = MovieDetailsCoordinatorSpy(navigationController: NavigationControllerSpy())
    
    private lazy var sut: MovieDetailsInteractor = {
        let interactor = MovieDetailsInteractor(
            presenter: presenterSpy,
            coordinator: coordinatorSpy,
            service: serviceMock,
            movieId: 617653)
        return interactor
    }()
    
    func testFetchMovieDetails_WhenResultIsSuccess_ShouldPresentMovie() {
        serviceMock.searchMovieIdExpectedResult = .success(.fixture())
        sut.fetchMovieDetails()
        
        XCTAssertEqual(presenterSpy.presentLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentMovieCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentMovieReceivedInvocation, .fixture())
    }
    
    func testFetchMovieDetails_WhenResultIsFailure_ShouldPresentError() {
        serviceMock.searchMovieIdExpectedResult = .failure(.generic)
        sut.fetchMovieDetails()
        
        XCTAssertEqual(presenterSpy.presentLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentErrorViewCallsCount, 1)
    }
}
