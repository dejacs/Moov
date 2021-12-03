//
//  MovieDetailsViewController.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol MovieDetailsDisplaying: AnyObject {
    func displayLoading()
    func startLoading()
    func hideLoading()
    func stopLoading()
    func display(movie: MovieResponse)
}

fileprivate enum Layout {
    enum Label {
        static let numberOfLines = 2
    }
}

final class MovieDetailsViewController: UIViewController {
    private lazy var loadingView: UIActivityIndicatorView = {
        return .init(style: .large)
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
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

extension MovieDetailsViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(overviewLabel)
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
    }
    
    func configureViews() {
        view.backgroundColor = .init(named: Strings.Color.primaryBackground)
        navigationController?.navigationBar.tintColor = .init(named: Strings.Color.navigationText)
        navigationController?.navigationBar.backgroundColor = .init(named: Strings.Color.branding)
        navigationController?.navigationBar.barTintColor = .init(named: Strings.Color.branding)
    }
}

extension MovieDetailsViewController: MovieDetailsDisplaying {
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
    
    func display(movie: MovieResponse) {
        title = movie.title
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        posterImageView.setImage(pathSufix: movie.posterPath)
    }
}
