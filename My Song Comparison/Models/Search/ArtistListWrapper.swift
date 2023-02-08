//
//  ArtistSearchObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

struct ArtistWrapper: Decodable {
    var artists: ItemsWrapper<ArtistObject>
    
    private enum CodingKeys: String, CodingKey {
        case artists
    }
}

extension ArtistWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artists = try container.decodeIfPresent(ItemsWrapper.self, forKey: .artists) ?? ItemsWrapper(items: [], total:0)
    }
}

//struct Artists<T:Decodable>: Decodable {
//    var items: [T]
//
//    private enum CodingKeys: String, CodingKey {
//        case items
//    }
//}
