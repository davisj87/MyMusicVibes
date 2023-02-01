//
//  PlaylistSearchObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

struct PlaylistWrapper: Decodable {
    var playlists: Playlists
}

struct Playlists: Decodable {
    var items: [PlaylistObject]
}
