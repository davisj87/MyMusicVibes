//
//  SearchAlbumEndpoint.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

struct SearchAlbumEndpoint: SearchEndpoint {
    
    var searchString: String
    
    var limit: Int
    
    var offset: Int
    
    var searchType: SearchType? {
        return .album
    }
    
    typealias ModelType = AlbumWrapper
}
