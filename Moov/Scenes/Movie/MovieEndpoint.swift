//
//  MovieEndpoint.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation
import NetworkCore

enum MovieEndpoint: EndpointProtocol {
    case trendingDaily
    case trendingWeekly
    case searchMovieId(Int)
    case searchText(String, page: Int)
    case downloadImage(pathSufix: String)
    
    var urlText: String {
        let apiKey = "[YOUR API KEY HERE]"
        let locale = NSLocalizedString(Strings.LocalizableKeys.locale, comment: "")
        
        switch self {
        case .trendingDaily:
            return "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)&language=\(locale)"
            
        case .trendingWeekly:
            return "https://api.themoviedb.org/3/trending/movie/week?api_key=\(apiKey)&language=\(locale)"
            
        case .searchMovieId(let id):
            return "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=\(locale)"
            
        case let .searchText(text, page):
            return "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=\(locale)&query=\(text)&page=\(page)"
            
        case .downloadImage(let pathSufix):
            return "https://image.tmdb.org/t/p/w500\(pathSufix)"
        }
    }
}
