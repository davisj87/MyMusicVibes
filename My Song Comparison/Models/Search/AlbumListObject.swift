//
//  AlbumSearchObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

struct AlbumWrapper: Decodable {
    var albums: Albums
}

struct Albums: Decodable {
    var items: [AlbumListObject]
}

struct AlbumListObject: Decodable {
    var id: String
    var name: String
    var artists: [AlbumArtistListObject]
    var images: [ImageObject]
}

struct AlbumArtistListObject: Decodable {
    var name: String
}
