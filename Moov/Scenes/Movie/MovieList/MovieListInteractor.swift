//
//  MovieListInteractor.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol MovieListInteracting {
    func fetchDailyTrendingMovieList()
    func search(by text: String)
    func loadNextPage(row: Int, loadingCellDelegate: LoadingCellDelegate)
    func didSelect(searchItem: MovieResponse)
}

extension MovieListInteracting {
    func search(by text: String = "") {
        search(by: text)
    }
}

final class MovieListInteractor: MovieListInteracting {
    private let presenter: MovieListPresenting
    private let coordinator: MovieListCoordinating
    private let service: MovieListServicing
    
    private var searchDataSource = [MovieResponse]()
    private var searchControl = SearchControl(text: "", totalPages: 0)
    private var isFetchInProgress = false
    
    init(presenter: MovieListPresenting, coordinator: MovieListCoordinating, service: MovieListServicing) {
        self.presenter = presenter
        self.coordinator = coordinator
        self.service = service
    }
    
    func fetchDailyTrendingMovieList() {
        guard !isFetchInProgress else { return }
        presenter.presentLoading()
        isFetchInProgress = true
        
        service.fetchDailyTrendingMovieList { [weak self] result in
            guard let self = self else { return }
            self.presenter.hideLoading()
            self.isFetchInProgress = false
            
            switch result {
            case .success(let movieList):
                self.presenter.present(movieListResponse: movieList)
            case .failure:
                self.presenter.presentErrorView()
            }
        }
    }
    
    func search(by text: String) {
        guard !isFetchInProgress else { return }
        presenter.presentLoading()
        isFetchInProgress = true
        
        service.search(movieText: text, page: searchControl.page) { [weak self] result in
            guard let self = self else { return }
            self.presenter.hideLoading()
            self.isFetchInProgress = false
            
            switch result {
            case .success(let movieList) where movieList.results.isEmpty:
                self.presenter.presentEmptyView()
                
            case .success(let movieList):
                self.searchDataSource = movieList.results
                self.searchControl = SearchControl(text: text, movieList: movieList)
                self.presenter.present(movieListResponse: movieList)
                
            case .failure:
                self.presenter.presentErrorView()
            }
        }
    }
    
    func loadNextPage(row: Int, loadingCellDelegate: LoadingCellDelegate) {
        guard !searchControl.text.isEmpty,
              searchControl.page < searchControl.totalPages - 1,
              searchDataSource.endIndex - 1 == row,
              !isFetchInProgress
        else { return }
        searchControl.page += 1
        isFetchInProgress = true
        loadingCellDelegate.displayLoading()
        
        service.search(movieText: searchControl.text, page: searchControl.page) { [weak self] result in
            guard let self = self else { return }
            self.isFetchInProgress = false
            loadingCellDelegate.hideLoading()
            
            switch result {
            case .success(let movieList) where movieList.results.isEmpty:
                return
                
            case .success(let movieList):
                self.searchDataSource = movieList.results
                self.searchControl = SearchControl(text: self.searchControl.text, movieList: movieList)
                self.presenter.present(movieListResponse: movieList)
                
            case .failure:
                self.presenter.presentErrorToast()
            }
        }
    }
    
    func didSelect(searchItem: MovieResponse) {
        coordinator.navigateToMovieDetails(movieId: searchItem.id)
    }
}
