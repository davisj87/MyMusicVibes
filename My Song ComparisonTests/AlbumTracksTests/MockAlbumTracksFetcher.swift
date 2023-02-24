//
//  MockAlbumTracksFetcher.swift
//  My Song ComparisonTests
//
//  Created by Jarred Davis on 2/24/23.
//

import Foundation
@testable import My_Song_Comparison


class MockAlbumTracksFetcher:AlbumTracksFetcherProtocol, MockableAPI {
    func getAlbumTracksIds(albumId: String) async throws -> String {
        return ""
    }
    
    func getTracks(ids: String) async throws -> [TracksObject] {
        guard let tracksArray = loadJSON(filename: "MockAlbumTracksResponse", type: TracksArrayObject.self) else {
            return []
        }
        return tracksArray.tracks
    }
    
    func getTracksDetails(ids: String) async throws -> Set<TrackFeaturesObject?> {
        guard let albumTracksDetailsWrapper = loadJSON(filename: "MockAlbumTracksDetailsResponse", type: TrackAudioFeatures.self) else {
            return []
        }
        return albumTracksDetailsWrapper.audioFeatures
    }
}
