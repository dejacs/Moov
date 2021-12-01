//
//  ViewConfiguration.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewConfiguration {
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
