//
//  SearchEndpoint.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

protocol SearchEndpoint: AuthorizedEndpoint {
    var searchString:String { get }
    var searchType: SearchType? { get }
}

extension SearchEndpoint {
    
    var host: String {
        return "https://api.spotify.com"
    }
    
    var path: String {
        return "/v1/search"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [String : String]? {
        var qDict:[String:String] = [:]
        if let searchType = self.searchType {
            if searchType == .all{
                qDict["type"] = "track,album,artist,playlist"
            } else {
                qDict["type"] = searchType.rawValue
            }
        }
        qDict["market"] = "US"
        qDict["q"] = self.searchString
        return qDict
    }
}

enum SearchType: String, CaseIterable {
    case all = "all"
    case album = "album"
    case artist = "artist"
    case playlist = "playlist"
    case track = "track"
}
