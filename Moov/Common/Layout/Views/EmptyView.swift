//
//  EmptyView.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

fileprivate enum Layout {
    enum ImageView {
        static let name = "img_empty"
        static let size = CGSize(width: 100, height: 100)
    }
}

final class EmptyView: UIView {
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: .init(named: Layout.ImageView.name))
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentCompressionResistancePriority(for: .vertical)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(LayoutDefaults.FontSize.base03)
        label.textColor = .init(named: Strings.Color.secondaryText)
        label.text = NSLocalizedString(Strings.LocalizableKeys.Search.Empty.title, comment: "")
        label.textAlignment = .center
        label.numberOfLines = LayoutDefaults.Label.numberOfLines
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(LayoutDefaults.FontSize.base02)
        label.textColor = .init(named: Strings.Color.tertiaryText)
        label.text = NSLocalizedString(Strings.LocalizableKeys.Search.Empty.message, comment: "")
        label.textAlignment = .center
        label.numberOfLines = LayoutDefaults.Label.numberOfLines
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension EmptyView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(messageLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Layout.ImageView.size.height),
            imageView.widthAnchor.constraint(equalToConstant: Layout.ImageView.size.width),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -LayoutDefaults.View.margin02)
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: LayoutDefaults.View.margin01),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -LayoutDefaults.View.margin01),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: LayoutDefaults.View.margin02),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -LayoutDefaults.View.margin02),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutDefaults.View.margin01)
        ])
    }
    
    func configureViews() {
        backgroundColor = .init(named: Strings.Color.primaryBackground)
    }
}
