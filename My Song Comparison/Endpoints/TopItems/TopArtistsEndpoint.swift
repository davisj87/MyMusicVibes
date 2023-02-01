//
//  TopArtistsEndpoint.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/12/23.
//

import Foundation

struct TopArtistsEndpoint: AuthorizedEndpoint {
    
    var host: String {
        return "https://api.spotify.com"
    }
    
    var path: String {
        return "/v1/me/top/artists"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [String : String]? {
        var qDict:[String:String] = [:]
        qDict["limit"] = "10"
        return qDict
    }
    
    typealias ModelType = ObjectItemWrapper<ArtistObject>
}
