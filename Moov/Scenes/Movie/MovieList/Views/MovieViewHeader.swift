//
//  MovieViewHeader.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

fileprivate enum Layout {
    enum Label {
        static let numberOfLines = 1
    }
}

final class MovieViewHeader: UIView {
    private lazy var totalResultsLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(LayoutDefaults.FontSize.base01)
        label.textColor = .init(named: Strings.Color.secondaryText)
        label.numberOfLines = Layout.Label.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func display(totalResults: Int) {
        totalResultsLabel.text = totalResults.description
    }
}

// MARK: - ViewConfiguration
extension MovieViewHeader: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(totalResultsLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            totalResultsLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -LayoutDefaults.View.margin01),
            totalResultsLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutDefaults.View.margin01),
            totalResultsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutDefaults.View.margin01),
            totalResultsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutDefaults.View.margin01)
        ])
    }
    
    func configureViews() {
        backgroundColor = .init(named: Strings.Color.primaryBackground)
    }
}
