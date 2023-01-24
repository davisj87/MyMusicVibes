//
//  TopArtistsObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/12/23.
//

import Foundation

struct TopArtistsObject: Decodable {
    var id: String
    var name: String
    var genres: [String]
    var followers: ArtistFollowersObject
    var images: [ImageObject]
    var popularity: Int
}
