//
//  TrackSearchObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

struct TracksWrapper: Decodable {
    var tracks: Tracks
}

struct Tracks: Decodable {
    var items: [TracksObject]
}
