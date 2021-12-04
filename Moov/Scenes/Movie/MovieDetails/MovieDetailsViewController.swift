//
//  MovieDetailsViewController.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol MovieDetailsDisplaying: AnyObject {
    func displayLoading()
    func hideLoading()
    func display(movie: MovieResponse)
    func hideMovie()
    func displayError()
    func hideError()
}

fileprivate enum Layout {
    enum Label {
        static let numberOfLines = 2
    }
}

final class MovieDetailsViewController: UIViewController {
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.accessibilityIdentifier = "movieDetailsScrollView"
        return scrollView
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentCompressionResistancePriority(for: .vertical)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(LayoutDefaults.FontSize.base0X)
        label.textColor = .init(named: Strings.Color.primaryText)
        label.numberOfLines = Layout.Label.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(LayoutDefaults.FontSize.base02)
        label.textColor = .init(named: Strings.Color.primaryText)
        label.numberOfLines = LayoutDefaults.Label.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var errorView: UIView = {
        let view = ErrorView()
        view.delegate = self
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let interactor: MovieDetailsInteracting
    
    init(interactor: MovieDetailsInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        interactor.fetchMovieDetails()
    }
}

// MARK: - ViewConfiguration
extension MovieDetailsViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(overviewLabel)
        view.addSubview(loadingView)
        view.addSubview(errorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: LayoutDefaults.View.margin01),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: LayoutDefaults.View.margin01),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.trailingAnchor, constant: -LayoutDefaults.View.margin01)
        ])
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutDefaults.View.margin01),
            overviewLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: LayoutDefaults.View.margin01),
            overviewLabel.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.trailingAnchor, constant: -LayoutDefaults.View.margin01),
            overviewLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -LayoutDefaults.View.margin01)
        ])
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .init(named: Strings.Color.primaryBackground)
        navigationController?.navigationBar.tintColor = .init(named: Strings.Color.navigationText)
        navigationController?.navigationBar.backgroundColor = .init(named: Strings.Color.branding)
        navigationController?.navigationBar.barTintColor = .init(named: Strings.Color.branding)
    }
}

// MARK: - MovieDetailsDisplaying
extension MovieDetailsViewController: MovieDetailsDisplaying {
    func displayLoading() {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    func hideLoading() {
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
    
    func display(movie: MovieResponse) {
        scrollView.isHidden = false
        title = movie.title
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        posterImageView.setImage(pathSufix: movie.posterPath)
    }
    
    func hideMovie() {
        scrollView.isHidden = true
    }
    
    func displayError() {
        errorView.isHidden = false
    }
    
    func hideError() {
        errorView.isHidden = true
    }
}

// MARK: - ErrorViewDelegate
extension MovieDetailsViewController: ErrorViewDelegate {
    func didTapButton() {
        interactor.fetchMovieDetails()
    }
}
