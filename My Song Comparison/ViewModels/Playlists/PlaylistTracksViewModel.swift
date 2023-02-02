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
    private (set) var trackDetailsArr = Set<TrackFeaturesObject?>()
    
    var trackCount:Int {
        return playlistTracks.count
    }
    
    func getTrackAndDetailsVM(at index:Int) -> TrackDetailTableViewCellViewModel {
        let playlistTrack = playlistTracks[index]
        let trackCellViewModel = TrackCellViewModel(tracksObject: playlistTracks[index].track)
        if let detailIndex = trackDetailsArr.firstIndex(of: TrackFeaturesObject(withId: playlistTrack.track.id)) {
            return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: trackDetailsArr[detailIndex])
        }
        return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: nil)
    }
    
    let playlist:PlaylistCellViewModel
    
    init(playlist:PlaylistCellViewModel) {
        self.playlist = playlist
    }
    
    func getTracks() async throws {
        let playlistTracksEndpoint = PlaylistTracksEndpoint(id: self.playlist.id)
        let playlistTracksRequest = APIRequest(endpoint: playlistTracksEndpoint, authManager: authManager)
        guard let playlistTracks = try await playlistTracksRequest.executeRequest() else { return }
        self.playlistTracks = playlistTracks.items
        self.trackDetailsArr = try await self.getTracksDetails(tracks: playlistTracks.items)
    }
    
    private func getTracksDetails(tracks:[PlaylistTrackObject]) async throws -> Set<TrackFeaturesObject?> {
        let trackIds = tracks.map{ $0.track.id }
        let trackIdsString = trackIds.joined(separator: ",")
        let tracksDetailsEndpoint = TracksDetailEndpoint(ids: trackIdsString)
        
        let tracksDetailsRequest = APIRequest(endpoint: tracksDetailsEndpoint, authManager: authManager)
        guard let trackDetails = try await tracksDetailsRequest.executeRequest() else { return [] }
        return trackDetails.audioFeatures
    }
    
}

