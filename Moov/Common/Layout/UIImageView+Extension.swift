//
//  UIImageView+Extension.swift
//  Moov
//
//  Created by Jade Silveira on 02/12/21.
//

import Foundation
import NatworkSPM
import UIKit

extension UIImageView {
    func setImage(pathSufix: String?) {
        guard let pathSufix = pathSufix else {
            DispatchQueue.main.async {
                self.image = UIImage(named: Strings.Placeholder.image)
            }
            return
        }
        Network().fetchData(urlText: MovieEndpoint.downloadImage(pathSufix: pathSufix).urlText) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let image):
                self.image = UIImage(data: image)
            case .failure:
                self.image = UIImage(named: Strings.Placeholder.image)
            }
        }
    }
}
