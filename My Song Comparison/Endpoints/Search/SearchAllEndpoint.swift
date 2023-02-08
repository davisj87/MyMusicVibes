//
//  SearchAllEndpoint.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/8/23.
//

import Foundation

struct SearchAllEndpoint: SearchEndpoint {
    var searchString: String
    
    var searchType: SearchType? {
        return nil
    }
    
    typealias ModelType = SearchAllWrapper
}
