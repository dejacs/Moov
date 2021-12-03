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
    enum ImageView {
        static let size = CGSize(width: 200, height: 500)
    }
    enum Label {
        static let numberOfLines = 2
    }
}

final class MovieDetailsViewController: UIViewController {
    private lazy var loadingView: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return .init(style: .large)
        }
        return .init(style: .medium)
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentCompressionResistancePriority(for: .vertical)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(LayoutDefaults.FontSize.base01)
        label.textColor = .init(named: Strings.Color.primaryText)
        label.numberOfLines = Layout.Label.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(LayoutDefaults.FontSize.base01)
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
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: LayoutDefaults.View.margin02),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutDefaults.View.margin01),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -LayoutDefaults.View.margin01)
        ])
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutDefaults.View.margin01),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutDefaults.View.margin01),
            overviewLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -LayoutDefaults.View.margin01),
            overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: LayoutDefaults.View.margin01)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .init(named: Strings.Color.primaryBackground)
        navigationController?.navigationBar.tintColor = .init(named: Strings.Color.backButton)
        navigationController?.navigationBar.backgroundColor = .init(named: Strings.Color.transparentBackground)
        navigationController?.navigationBar.barTintColor = .init(named: Strings.Color.transparentBackground)
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
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        posterImageView.setImage(pathSufix: movie.posterPath)
    }
}
