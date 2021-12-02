//
//  MovieViewCell.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

fileprivate enum Layout {
    enum Cell {
        static let identifier = "MovieViewCell"
    }
    enum Label {
        static let numberOfLines = 1
    }
}

class MovieViewCell: UITableViewCell {
    static let identifier = Layout.Cell.identifier
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(LayoutDefaults.FontSize.base01)
        label.textColor = .init(named: Strings.Color.primaryText)
        label.numberOfLines = LayoutDefaults.Label.numberOfLines
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
        titleLabel.text = nil
    }
    
    func setup(searchItem: MovieResponse) {
        titleLabel.text = searchItem.title
        layoutIfNeeded()
    }
}

// MARK: - ViewConfiguration
extension MovieViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: LayoutDefaults.View.margin01),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -LayoutDefaults.View.margin01),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutDefaults.View.margin01),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: LayoutDefaults.View.margin01)
        ])
    }
    
    func configureViews() {
        backgroundColor = .init(named: Strings.Color.transparentBackground)
        selectionStyle = .none
    }
}
