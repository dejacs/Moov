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
    case search(movieId: Int)
    
    var urlText: String {
        let apiKey = "[YOUR API KEY HERE]"
        
        switch self {
        case .trendingDaily:
            return "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)"
            
        case .trendingWeekly:
            return "https://api.themoviedb.org/3/trending/movie/week?api_key=\(apiKey)"
            
        case .search(let movieId):
            return "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)"
        }
    }
}
