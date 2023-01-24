//
//  ArtistSearchObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

struct ArtistWrapper: Decodable {
    var artists: Artists
}

struct Artists: Decodable {
    var items: [ArtistListObject]
}

struct ArtistListObject: Decodable {
    var id: String
    var name: String
    var followers: ArtistFollowersObject
    var images: [ImageObject]
}
