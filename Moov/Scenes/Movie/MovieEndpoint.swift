//
//  MovieEndpoint.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation
import NetworkCore

enum MovieEndpoint {
    case trendingDaily
    case trendingWeekly
    case searchMovieId(Int)
    case searchText(String, page: Int)
    case downloadImage(pathSufix: String)
    
    var urlText: String {
        let apiKey = "5725d89a6357e321ddfa9db44c0dfc27"
        let locale = NSLocalizedString(Strings.LocalizableKeys.locale, comment: "")
        guard let host = Enviroment.Host.api, let imageHost = Enviroment.Host.imageApi else { return "" }
        
        switch self {
        case .trendingDaily:
            return "\(host)/trending/movie/day?api_key=\(apiKey)&language=\(locale)"
            
        case .trendingWeekly:
            return "\(host)/trending/movie/week?api_key=\(apiKey)&language=\(locale)"
            
        case .searchMovieId(let id):
            return "\(host)/movie/\(id)?api_key=\(apiKey)&language=\(locale)"
            
        case let .searchText(text, page):
            return "\(host)/search/movie?api_key=\(apiKey)&language=\(locale)&query=\(text)&page=\(page)"
            
        case .downloadImage(let pathSufix):
            return imageHost + pathSufix
        }
    }
}
