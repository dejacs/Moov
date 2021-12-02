//
//  MovieListInteractor.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol MovieListInteracting {
    func fetchDailyTrendingMovieList()
    func search(by text: String)
    func loadNextPage()
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
    
    init(presenter: MovieListPresenting, coordinator: MovieListCoordinating, service: MovieListServicing) {
        self.presenter = presenter
        self.coordinator = coordinator
        self.service = service
    }
    
    func fetchDailyTrendingMovieList() {
        self.presenter.presentLoading()
        
        service.fetchDailyTrendingMovieList { [weak self] result in
            guard let self = self else { return }
            self.presenter.hideLoading()
            
            switch result {
            case .success(let movieList):
                self.presenter.present(movieListResponse: movieList)
            case .failure:
                print("failure")
            }
        }
    }
    
    func search(by text: String) {
        
    }
    
    func loadNextPage() {
        
    }
    
    func didSelect(searchItem: MovieResponse) {
        coordinator.navigateToMovieDetails(movieId: searchItem.id)
    }
}
