//
//  SearchTrackEndpoint.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

struct SearchTrackEndpoint: SearchEndpoint {
    var searchString: String

    var searchType: SearchType {
        return .track
    }
    typealias ModelType = TracksWrapper
}
