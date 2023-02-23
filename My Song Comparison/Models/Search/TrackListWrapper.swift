//
//  TrackSearchObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

import Foundation

struct TracksWrapper: Decodable {
    var tracks: ItemsWrapper<TracksObject>
    
    private enum CodingKeys: String, CodingKey {
        case tracks
    }
}

extension TracksWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tracks = try container.decodeIfPresent(ItemsWrapper.self, forKey: .tracks) ?? ItemsWrapper(items: [], total:0)
    }
}
