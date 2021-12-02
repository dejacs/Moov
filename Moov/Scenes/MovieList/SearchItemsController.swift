//
//  SearchItemsController.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import UIKit

final class SearchItemsController: UISearchController {
    private var isSearchBarEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func setupSearchBar(delegate: UISearchBarDelegate) {
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = Strings.Placeholder.search
        searchBar.backgroundColor = .init(named: Strings.Color.branding)
        searchBar.delegate = delegate
        
        if let searchBarContainer = searchBar.subviews.first?.subviews[1],
           let textField = searchBarContainer.subviews.first(where: { view in view is UITextField }) {
            textField.tintColor = .init(named: Strings.Color.tertiaryText)
            textField.backgroundColor = .init(named: Strings.Color.primaryBackground)
            textField.layer.cornerRadius = LayoutDefaults.CornerRadius.base00
            textField.layer.masksToBounds = true
        }
    }
}
