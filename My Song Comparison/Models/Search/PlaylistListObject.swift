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
    var items: [PlaylistListObject]
}

struct PlaylistListObject: Decodable {
    var id: String
    var name: String
    var owner: PlaylistOwnerObject
    var images: [ImageObject]
}

struct PlaylistOwnerObject: Decodable {
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "display_name"
    }
}
