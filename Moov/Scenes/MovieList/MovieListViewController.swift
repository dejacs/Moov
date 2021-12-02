//
//  MovieListViewController.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation
import UIKit

protocol MovieListDisplaying: AnyObject {
    func displayLoading()
    func startLoading()
    func hideLoading()
    func stopLoading()
    func display(movieList: MovieListResponse)
    func displaySearchResponse(shouldDisplay: Bool)
}

fileprivate enum Layout {
    enum StackView {
        static let layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}

final class MovieListViewController: UIViewController {
    private lazy var loadingView: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return .init(style: .large)
        }
        return .init(style: .medium)
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = SearchItemsController(searchResultsController: nil)
        searchController.setupSearchBar(delegate: self)
        return searchController
    }()
    
    private lazy var searchResultTable: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResultViewCell.self, forCellReuseIdentifier: SearchResultViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .init(named: Strings.Color.primaryBackground)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var emptyView = EmptyView()
    private lazy var errorView: UIView = {
        let view = ErrorView()
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    private var searchDataSource = [MovieResponse]()
    private var totalResults = 0
    
    private let interactor: MovieListInteracting
    
    init(interactor: MovieListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        interactor.fetchDailyTrendingMovieList()
    }
}

extension MovieListViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(searchResultTable)
        view.addSubview(emptyView)
        view.addSubview(errorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchResultTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchResultTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureViews() {
        navigationController?.navigationBar.backgroundColor = .init(named: Strings.Color.branding)
        navigationController?.navigationBar.barTintColor = .init(named: Strings.Color.branding)
        view.backgroundColor = .init(named: Strings.Color.branding)
        emptyView.isHidden = true
        loadingView.isHidden = true
        setupSearchBar()
    }
}


// MARK: - Private methods
private extension MovieListViewController {
    func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func shouldLoadNextPage(row: Int) -> Bool {
        row == searchDataSource.endIndex - 1 && totalResults > searchDataSource.count
    }
}


// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewCell.identifier) as? SearchResultViewCell
        else { return .init() }
        cell.setup(searchItem: searchDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SearchResultViewHeader()
        view.display(totalResults: totalResults)
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard shouldLoadNextPage(row: indexPath.row) else { return }
        interactor.loadNextPage()
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchDataSource = []
        interactor.search(by: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { }
}

// MARK: - MovieListDisplaying
extension MovieListViewController: MovieListDisplaying {
    func startLoading() {
        loadingView.startAnimating()
    }
    
    func displayLoading() {
        loadingView.isHidden = false
    }
    
    func stopLoading() {
        loadingView.stopAnimating()
    }
    
    func hideLoading() {
        loadingView.isHidden = true
    }
    
    func display(movieList: MovieListResponse) {
        totalResults = movieList.totalResults
        searchDataSource.append(contentsOf: movieList.results)
        searchResultTable.reloadData()
    }
    
    func displaySearchResponse(shouldDisplay: Bool) {
        searchResultTable.isHidden = !shouldDisplay
    }
}

// MARK: - ErrorViewDelegate
extension MovieListViewController: ErrorViewDelegate {
    func didTapButton() {
        interactor.search()
    }
}
