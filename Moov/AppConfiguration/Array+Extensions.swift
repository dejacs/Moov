//
//  Array+Extensions.swift
//  Moov
//
//  Created by Jade on 22/07/22.
//

import Foundation

extension Array {
    mutating func append(_ element: Element?) {
        guard let element = element else { return }
        append(element)
    }
}
