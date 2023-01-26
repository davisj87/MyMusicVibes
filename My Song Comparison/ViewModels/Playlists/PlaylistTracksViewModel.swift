//
//  PlaylistTracksViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/19/23.
//

import Foundation


class PlaylistTracksViewModel: TrackDetailViewFormatter {
    
    private let authManager = AuthManager()
    private var playlistTracks:[PlaylistTrackObject] = []
    private var trackDetails = Set<TrackFeaturesObject>()
    
    var trackCount:Int {
        return playlistTracks.count
    }
    
    func getTrackAndDetailsVM(at index:Int) -> TrackViewModel {
        let playlistTrack = playlistTracks[index]
        if let detailIndex = trackDetails.firstIndex(of: TrackFeaturesObject(withId: playlistTrack.track.id)) {
            return TrackViewModel(track: playlistTrack.track, trackDetail: trackDetails[detailIndex])
        }
        return TrackViewModel(track: playlistTrack.track, trackDetail: nil)
    }
    
    func getExtTrackDetail(trackId: String) -> TrackFeaturesObject? {
        if let index = trackDetails.firstIndex(of: TrackFeaturesObject(withId: trackId)) {
            let trackDetail = trackDetails[index]
            return trackDetail
        }
        return nil
    }
    
    private var id:String
    
    init(id:String) {
        self.id = id
    }
    
    func getTracks() async throws {
        let playlistTracksEndpoint = PlaylistTracksEndpoint(id: id)
        let playlistTracksRequest = APIRequest(endpoint: playlistTracksEndpoint, authManager: authManager)
        guard let playlistTracks = try await playlistTracksRequest.executeRequest() else { return }
        self.playlistTracks = playlistTracks.items
        self.trackDetails = try await self.getTracksDetails(tracks: playlistTracks.items)
    }
    
    private func getTracksDetails(tracks:[PlaylistTrackObject]) async throws -> Set<TrackFeaturesObject> {
        let trackIds = tracks.map{ $0.track.id }
        let trackIdsString = trackIds.joined(separator: ",")
        let tracksDetailsEndpoint = TracksDetailEndpoint(ids: trackIdsString)
        
        let tracksDetailsRequest = APIRequest(endpoint: tracksDetailsEndpoint, authManager: authManager)
        guard let trackDetails = try await tracksDetailsRequest.executeRequest() else { return [] }
        return trackDetails.audioFeatures
    }
    
}

