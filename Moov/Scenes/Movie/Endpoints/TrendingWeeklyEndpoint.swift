//
//  TrendingWeeklyEndpoint.swift
//  Moov
//
//  Created by Jade Silveira on 22/04/24.
//

import Foundation
import NatworkSPM

struct TrendingWeeklyEndpoint: EndpointProtocol {
    var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    var decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    
    let host: String = Enviroment.Host.api ?? ""
    let method: NatworkSPM.EndpointMethod = .get
    
    let apiVersion: String = "3"
    var path: String { "/\(apiVersion)/trending/movie/week" }
    
    let apiKey = "5725d89a6357e321ddfa9db44c0dfc27"
    let locale = NSLocalizedString(Strings.LocalizableKeys.locale, comment: "")
    var params: [String : Any] { ["api_key": apiKey, "language": locale] }
}
