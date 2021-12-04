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
    func hideLoading()
    func display(movieList: MovieListResponse)
    func hideMovieList()
    func displayEmpty()
    func displayError()
    func hideEmpty()
    func hideError()
}

fileprivate enum Layout {
    enum StackView {
        static let layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}

final class MovieListViewController: UIViewController {
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = CustomSearchController(searchResultsController: nil)
        searchController.setupSearchBar(delegate: self)
        return searchController
    }()
    
    private lazy var searchResultTable: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieViewCell.self, forCellReuseIdentifier: MovieViewCell.identifier)
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
    
    private lazy var emptyView: UIView = {
        let view = EmptyView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorView: UIView = {
        let view = ErrorView()
        view.delegate = self
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
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


// MARK: - ViewConfiguration
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
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureViews() {
        navigationController?.navigationBar.backgroundColor = .init(named: Strings.Color.branding)
        navigationController?.navigationBar.barTintColor = .init(named: Strings.Color.branding)
        view.backgroundColor = .init(named: Strings.Color.branding)
        
        title = NSLocalizedString(Strings.LocalizableKeys.Welcome.title, comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: Strings.Color.navigationText) as Any]
        
        loadingView.isHidden = true
        setupSearchBar()
    }
}


// MARK: - Private methods
private extension MovieListViewController {
    func setupSearchBar() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}


// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier) as? MovieViewCell
        else { return .init() }
        guard indexPath.row != searchDataSource.endIndex, searchDataSource.indices.contains(indexPath.row) else {
            return cell
        }
        cell.setup(searchItem: searchDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = MovieViewHeader()
        viewHeader.display(totalResults: totalResults)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier) as? MovieViewCell
        else { return }
        interactor.loadNextPage(row: indexPath.row, loadingCellDelegate: cell)
    }
}


// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.goToMovieDetails(searchItem: searchDataSource[indexPath.row])
    }
}


// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchDataSource.removeAll()
        searchResultTable.reloadData()
        interactor.search(by: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { }
}


// MARK: - MovieListDisplaying
extension MovieListViewController: MovieListDisplaying {
    func displayLoading() {
        loadingView.isHidden = false
        view.bringSubviewToFront(loadingView)
        loadingView.startAnimating()
    }
    
    func hideLoading() {
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
    
    func display(movieList: MovieListResponse) {
        searchResultTable.isHidden = false
        view.bringSubviewToFront(searchResultTable)
        totalResults = movieList.totalResults
        searchDataSource.append(contentsOf: movieList.results)
        searchResultTable.reloadData()
    }
    
    func hideMovieList() {
        searchResultTable.isHidden = true
    }
    
    func displayEmpty() {
        view.bringSubviewToFront(emptyView)
        emptyView.isHidden = false
    }
    
    func hideEmpty() {
        emptyView.isHidden = true
    }
    
    func displayError() {
        view.bringSubviewToFront(errorView)
        errorView.isHidden = false
    }
    
    func hideError() {
        errorView.isHidden = true
    }
}


// MARK: - ErrorViewDelegate
extension MovieListViewController: ErrorViewDelegate {
    func didTapButton() {
        interactor.fetchDailyTrendingMovieList()
    }
}
