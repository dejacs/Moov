//
//  ErrorView.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapButton()
}

fileprivate enum Layout {
    enum ImageView {
        static let name = "img_error"
        static let size = CGSize(width: 100, height: 100)
    }
}

final class ErrorView: UIView {
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: Layout.ImageView.name))
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentCompressionResistancePriority(for: .vertical)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(LayoutDefaults.FontSize.base03)
        label.textColor = UIColor(named: Strings.Color.secondaryText)
        label.text = NSLocalizedString(Strings.LocalizableKeys.errorSearchTitle, comment: "")
        label.textAlignment = .center
        label.numberOfLines = LayoutDefaults.Label.numberOfLines
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(LayoutDefaults.FontSize.base02)
        label.textColor = UIColor(named: Strings.Color.tertiaryText)
        label.text = NSLocalizedString(Strings.LocalizableKeys.errorSearchMessage, comment: "")
        label.textAlignment = .center
        label.numberOfLines = LayoutDefaults.Label.numberOfLines
        return label
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString(Strings.LocalizableKeys.errorSearchButton, comment: ""), for: .normal)
        button.setTitleColor(UIColor(named: Strings.Color.linkText), for: .normal)
        button.addTarget(self, action: #selector(didTapTryAgainButton), for: .touchUpInside)
        return button
    }()
    
    var delegate: ErrorViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension ErrorView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(tryAgainButton)
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
        NSLayoutConstraint.activate([
            tryAgainButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: LayoutDefaults.View.margin01),
            tryAgainButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -LayoutDefaults.View.margin01),
            tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryAgainButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: LayoutDefaults.View.margin01)
        ])
    }
    
    func configureViews() {
        backgroundColor = UIColor(named: Strings.Color.primaryBackground)
    }
}

@objc
extension ErrorView {
    func didTapTryAgainButton() {
        delegate?.didTapButton()
    }
}
