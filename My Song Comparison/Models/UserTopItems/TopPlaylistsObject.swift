//
//  TopPlaylistsObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/17/23.
//

import Foundation
struct TopPlaylistsObject: Decodable {
    var name: String
    var id: String
    var owner: TopPlaylistOwner
    var images: [ImageObject]
}

struct TopPlaylistOwner: Decodable {
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "display_name"
    }
}
