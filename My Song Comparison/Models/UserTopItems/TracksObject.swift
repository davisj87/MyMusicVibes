//
//  TopTracksObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/12/23.
//

import Foundation

struct TracksArrayObject: Codable {
    var tracks: [TracksObject]
}

struct TracksObject: Codable {
    var id: String
    var name: String
    var popularity: Int
    var album:TrackAlbumObject
    var artists: [TrackArtistObject]
    
    private enum CodingKeys: String, CodingKey {
        case id, name, popularity, album, artists
    }
}

extension TracksObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? "N/A"
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        self.popularity = try container.decodeIfPresent(Int.self, forKey: .popularity) ?? -1
        self.album = try container.decodeIfPresent(TrackAlbumObject.self, forKey: .album) ?? TrackAlbumObject(images: [], name: "")
        self.artists = try container.decodeIfPresent([TrackArtistObject].self, forKey: .artists) ?? []

    }
}

struct TrackArtistObject: Codable {
    var name: String
}

struct TrackAlbumObject: Codable {
    var images: [ImageObject]
    var name: String
}
