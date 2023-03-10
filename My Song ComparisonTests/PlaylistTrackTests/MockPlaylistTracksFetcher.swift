//
//  File.swift
//  My Song ComparisonTests
//
//  Created by Jarred Davis on 2/20/23.
//

import Foundation
@testable import My_Song_Comparison


class MockPlaylistTracksFetcher:PlaylistTracksFetcherProtocol, MockableAPI {
    
    func getTracks(playlistId: String) async throws -> [PlaylistTrackObject] {
        guard let playlistWrapper = loadJSON(filename: "MockPlaylistTrackResponse", type: ObjectItemWrapper<PlaylistTrackObject>.self) else {
            return []
        }
        return playlistWrapper.items
    }
    
   func getTracksDetails(tracks:[PlaylistTrackObject]) async throws -> Set<TrackFeaturesObject?> {
       
       guard let playlistTracksDetailsWrapper = loadJSON(filename: "MockPlaylistTracksDetailsResponse", type: TrackAudioFeatures.self) else {
           return []
       }
       return playlistTracksDetailsWrapper.audioFeatures
    }
}
