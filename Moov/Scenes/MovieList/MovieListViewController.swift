//
//  MovieListViewController.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation
import UIKit

protocol MovieListDisplaying: AnyObject {
    
}

final class MovieListViewController: UIViewController {
    private lazy var loadingView: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .large)
        }
        return UIActivityIndicatorView(style: .medium)
    }()
    
    private let interactor: MovieListInteracting
    
    init(interactor: MovieListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
}

extension MovieListViewController: MovieListDisplaying {
    
}
