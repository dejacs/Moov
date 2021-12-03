//
//  UIImageView+Extension.swift
//  Moov
//
//  Created by Jade Silveira on 02/12/21.
//

import Foundation
import NetworkCore
import UIKit

extension UIImageView {
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        return activityIndicator
    }
    
    func setImage(pathSufix: String?) {
        guard let pathSufix = pathSufix else {
            image = UIImage(named: Strings.Placeholder.image)
            return
        }
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        Network().fetchImage(with: MovieEndpoint.downloadImage(pathSufix: pathSufix)) { [weak self] result in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            
            switch result {
            case .success(let image):
                self.image = image
            case .failure:
                self.image = UIImage(named: Strings.Placeholder.image)
            }
        }
    }
}
