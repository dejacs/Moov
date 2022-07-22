//
//  MovieListInteractorTests.swift
//  MoovTests
//
//  Created by Jade Silveira on 01/12/21.
//

import XCTest
@testable import Moov

private final class MovieCellSpy: LoadingCellDelegate {
    private(set) var displayLoadingCallsCount = 0
    private(set) var hideLoadingCallsCount = 0
    
    func displayLoading() {
        displayLoadingCallsCount += 1
    }
    
    func hideLoading() {
        hideLoadingCallsCount += 1
    }
}

private final class MovieListPresenterSpy: MovieListPresenting {
    private(set) var presentLoadingCallsCount = 0
    private(set) var hideLoadingCallsCount = 0
    private(set) var presentMovieListResponseCallsCount = 0
    private(set) var presentEmptyViewCallsCount = 0
    private(set) var presentErrorViewCallsCount = 0
    
    private(set) var presentMovieListResponseReceivedInvocation: MovieListResponse?
    
    func presentLoading() {
        presentLoadingCallsCount += 1
    }
    
    func hideLoading() {
        hideLoadingCallsCount += 1
    }
    
    func present(movieListResponse: MovieListResponse) {
        presentMovieListResponseCallsCount += 1
        presentMovieListResponseReceivedInvocation = movieListResponse
    }
    
    func presentEmptyView() {
        presentEmptyViewCallsCount += 1
    }
    
    func presentErrorView() {
        presentErrorViewCallsCount += 1
    }
}

private final class MovieListCoordinatorSpy: MovieListCoordinating {
    var childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    private(set) var startCallsCount = 0
    private(set) var navigateToMovieDetailsCallsCount = 0
    
    private(set) var navigateToMovieDetailsReceivedInvocation: Int?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startCallsCount += 1
    }
    
    func navigateToMovieDetails(movieId: Int) {
        navigateToMovieDetailsCallsCount += 1
        navigateToMovieDetailsReceivedInvocation = movieId
    }
}

private final class MovieListServiceMock: MovieListServicing {
    var fetchDailyTrendingMovieListExpectedResult: Result<MovieListResponse, ApiError>?
    var fetchWeeklyTrendingMovieListExpectedResult: Result<MovieListResponse, ApiError>?
    var searchMovieTextExpectedResult: Result<MovieListResponse, ApiError>?
    
    func fetchDailyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        guard let expectedResult = fetchDailyTrendingMovieListExpectedResult else {
            XCTFail("Expected result was not defined.")
            return
        }
        completion(expectedResult)
    }
    
    func fetchWeeklyTrendingMovieList(completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        guard let expectedResult = fetchWeeklyTrendingMovieListExpectedResult else {
            XCTFail("Expected result was not defined.")
            return
        }
        completion(expectedResult)
    }
    
    func search(movieText: String, page: Int, completion: @escaping (Result<MovieListResponse, ApiError>) -> Void) {
        guard let expectedResult = searchMovieTextExpectedResult else {
            XCTFail("Expected result was not defined.")
            return
        }
        completion(expectedResult)
    }
}

final class MovieListInteractorTests: XCTestCase {
    private lazy var coordinatorSpy = MovieListCoordinatorSpy(navigationController: NavigationControllerSpy())
    
    private let presenterSpy = MovieListPresenterSpy()
    private let serviceMock = MovieListServiceMock()
    
    private lazy var sut: MovieListInteractor = {
        let interactor = MovieListInteractor(
            presenter: presenterSpy,
            coordinator: coordinatorSpy,
            service: serviceMock)
        return interactor
    }()
    
    func testFetchDailyTrendingMovieList_WhenResultIsSuccess_ShouldPresentMovieList() {
        serviceMock.fetchDailyTrendingMovieListExpectedResult = .success(.fixture())
        sut.fetchDailyTrendingMovieList()
        
        XCTAssertEqual(presenterSpy.presentLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentMovieListResponseCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentMovieListResponseReceivedInvocation, .fixture())
    }
    
    func testFetchDailyTrendingMovieList_WhenResultIsFailure_ShouldPresentError() {
        serviceMock.fetchDailyTrendingMovieListExpectedResult = .failure(.generic)
        sut.fetchDailyTrendingMovieList()
        
        XCTAssertEqual(presenterSpy.presentLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentErrorViewCallsCount, 1)
    }
    
    func testSearchByText_WhenResultIsSuccessAndHasItems_ShouldPresentMovieList() {
        serviceMock.searchMovieTextExpectedResult = .success(.fixture())
        sut.search(by: "Test")
        
        XCTAssertEqual(presenterSpy.presentLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentMovieListResponseCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentMovieListResponseReceivedInvocation, .fixture())
    }
    
    func testSearchByText_WhenResultIsSuccessAndItemsIsEmpty_ShouldPresentEmpty() {
        serviceMock.searchMovieTextExpectedResult = .success(.fixture(results: []))
        sut.search(by: "Test")
        
        XCTAssertEqual(presenterSpy.presentLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentEmptyViewCallsCount, 1)
    }
    
    func testSearchByText_WhenResultIsFailure_ShouldPresentError() {
        serviceMock.searchMovieTextExpectedResult = .failure(.generic)
        sut.search(by: "Test")
        
        XCTAssertEqual(presenterSpy.presentLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentErrorViewCallsCount, 1)
    }
    
    func testLoadNextPage_WhenSearchMovieRequestIsSuccessAndLoadNextPageRequestIsSuccessAndHasItems_ShouldPresentMoreCells() {
        let cellSpy = MovieCellSpy()
        serviceMock.searchMovieTextExpectedResult = .success(.fixture())
        sut.search(by: "Test")
        sut.loadNextPage(row: 0, loadingCellDelegate: cellSpy)
        
        XCTAssertEqual(cellSpy.displayLoadingCallsCount, 1)
        XCTAssertEqual(cellSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentMovieListResponseCallsCount, 2)
        XCTAssertEqual(presenterSpy.presentMovieListResponseReceivedInvocation, .fixture())
    }
    
    func testLoadNextPage_WhenSearchMovieRequestIsSuccessAndLoadNextPageRequestIsSuccessAndEmpty_ShouldDoNothing() {
        let cellSpy = MovieCellSpy()
        serviceMock.searchMovieTextExpectedResult = .success(.fixture())
        sut.search(by: "Test")
        serviceMock.searchMovieTextExpectedResult = .success(.fixture(results: []))
        sut.loadNextPage(row: 0, loadingCellDelegate: cellSpy)
        
        XCTAssertEqual(cellSpy.displayLoadingCallsCount, 1)
        XCTAssertEqual(cellSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentMovieListResponseCallsCount, 1)
    }
    
    func testLoadNextPage_WhenSearchMovieRequestIsSuccessAndLoadNextPageRequestIsFailure_ShouldDoNothing() {
        let cellSpy = MovieCellSpy()
        serviceMock.searchMovieTextExpectedResult = .success(.fixture())
        sut.search(by: "Test")
        serviceMock.searchMovieTextExpectedResult = .failure(.generic)
        sut.loadNextPage(row: 0, loadingCellDelegate: cellSpy)
        
        XCTAssertEqual(cellSpy.displayLoadingCallsCount, 1)
        XCTAssertEqual(cellSpy.hideLoadingCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentMovieListResponseCallsCount, 1)
    }
    
    func testGoToMovieDetails_ShouldNavigateToMovieDetails() {
        sut.goToMovieDetails(searchItem: .fixture())
        
        XCTAssertEqual(coordinatorSpy.navigateToMovieDetailsCallsCount, 1)
        XCTAssertEqual(coordinatorSpy.navigateToMovieDetailsReceivedInvocation, MovieResponse.fixture().id)
    }
}
