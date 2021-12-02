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
    case searchText(String)
    
    var urlText: String {
        let apiKey = "[YOUR API KEY HERE]"
        
        switch self {
        case .trendingDaily:
            return "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)"
            
        case .trendingWeekly:
            return "https://api.themoviedb.org/3/trending/movie/week?api_key=\(apiKey)"
            
        case .searchMovieId(let id):
            return "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)"
            
        case .searchText(let text):
            return "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(text)"
        }
    }
}
