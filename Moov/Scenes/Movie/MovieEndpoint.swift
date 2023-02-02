//
//  MovieEndpoint.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation
import NatworkSPM

struct TrendingDailyEndpoint: EndpointProtocol {
    var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    var decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    
    let host: String = Enviroment.Host.api ?? ""
    let method: NatworkSPM.EndpointMethod = .get
    
    let apiVersion: String = "3"
    var path: String { "/\(apiVersion)/trending/movie/day" }
    
    let apiKey = "5725d89a6357e321ddfa9db44c0dfc27"
    let locale = NSLocalizedString(Strings.LocalizableKeys.locale, comment: "")
    var params: [String : Any] { ["api_key": apiKey, "language": locale] }
}

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

struct MovieSearchIdEndpoint: EndpointProtocol {
    var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    var decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    
    let host: String = Enviroment.Host.api ?? ""
    let method: NatworkSPM.EndpointMethod = .get
    
    let apiVersion: String = "3"
    var path: String { "/\(apiVersion)/movie/\(id)" }
    var id: String
    
    let apiKey = "5725d89a6357e321ddfa9db44c0dfc27"
    let locale = NSLocalizedString(Strings.LocalizableKeys.locale, comment: "")
    var params: [String : Any] { ["api_key": apiKey, "language": locale] }
}

struct SearchTextEndpoint: EndpointProtocol {
    var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    var decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    
    let host: String = Enviroment.Host.api ?? ""
    let method: NatworkSPM.EndpointMethod = .get
    
    let apiVersion: String = "3"
    var path: String { "/\(apiVersion)/search/movie" }
    
    let apiKey = "5725d89a6357e321ddfa9db44c0dfc27"
    let locale = NSLocalizedString(Strings.LocalizableKeys.locale, comment: "")
    var text: String
    var page: String
    var params: [String : Any] { ["api_key": apiKey,
                                  "language": locale,
                                  "query": text,
                                  "page": page] }
}

struct DownloadImageEndpoint: EndpointProtocol {
    var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    
    let host: String = Enviroment.Host.imageApi ?? ""
    let method: NatworkSPM.EndpointMethod = .get
    
    var path: String { "/t/p/w500/\(pathSufix)" }
    var pathSufix: String
}
