//
//  MovieViewCell.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol LoadingCellDelegate: AnyObject {
    func displayLoading()
    func hideLoading()
}

fileprivate enum Layout {
    enum ImageView {
        static let size = CGSize(width: 100, height: 100)
    }
    enum Cell {
        static let identifier = "MovieViewCell"
    }
    enum Label {
        static let numberOfLines = 2
    }
}

class MovieViewCell: UITableViewCell {
    static let identifier = Layout.Cell.identifier
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.numberOfLines = Layout.Label.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    override func prepareForReuse() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
        titleLabel.text = nil
        overviewLabel.text = nil
        posterImageView.image = nil
    }
    
    func setup(searchItem: MovieResponse) {
        titleLabel.text = searchItem.title
        overviewLabel.text = searchItem.overview
        posterImageView.setImage(pathSufix: searchItem.posterPath)
    }
}

// MARK: - ViewConfiguration
extension MovieViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(overviewLabel)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutDefaults.View.margin01),
            posterImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: LayoutDefaults.View.margin01),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -LayoutDefaults.View.margin01),
            posterImageView.heightAnchor.constraint(equalToConstant: Layout.ImageView.size.height),
            posterImageView.widthAnchor.constraint(equalToConstant: Layout.ImageView.size.width),
            posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: LayoutDefaults.View.margin00),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -LayoutDefaults.View.margin01),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
        ])
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutDefaults.View.margin00),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: LayoutDefaults.View.margin00),
            overviewLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -LayoutDefaults.View.margin01),
            overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: LayoutDefaults.View.margin01)
        ])
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: bottomAnchor, constant: LayoutDefaults.View.margin01),
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutDefaults.View.margin01)
        ])
    }
    
    func configureViews() {
        backgroundColor = .init(named: Strings.Color.transparentBackground)
        selectionStyle = .none
    }
}

extension MovieViewCell: LoadingCellDelegate {
    func displayLoading() {
        loadingView.startAnimating()
        loadingView.isHidden = false
        bringSubviewToFront(loadingView)
    }
    func hideLoading() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
}
