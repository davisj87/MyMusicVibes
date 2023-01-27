//
//  SearchPlaylistEndpoint.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

struct SearchPlaylistEndpoint: SearchEndpoint {
    var searchString: String
    
    var searchType: SearchType {
        return .track
    }

    typealias ModelType = PlaylistWrapper
    
}
