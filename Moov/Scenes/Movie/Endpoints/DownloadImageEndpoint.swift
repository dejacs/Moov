//
//  DownloadImageEndpoint.swift
//  Moov
//
//  Created by Jade Silveira on 22/04/24.
//

import Foundation
import NatworkSPM

struct DownloadImageEndpoint: EndpointProtocol {
    var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    
    let host: String = Enviroment.Host.imageApi ?? ""
    let method: NatworkSPM.EndpointMethod = .get
    
    var path: String { "/t/p/w500/\(pathSufix)" }
    var pathSufix: String
}
