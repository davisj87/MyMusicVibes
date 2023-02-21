//
//  PlaylistTracksViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/19/23.
//

import Foundation

protocol PlaylistTracksFetcherProtocol {
    func getTracks(playlistId:String) async throws -> [PlaylistTrackObject]
    func getTracksDetails(tracks:[PlaylistTrackObject]) async throws -> Set<TrackFeaturesObject?>
}

struct PlaylistTracksFetcher:PlaylistTracksFetcherProtocol {
    private let authManager = AuthManager()
    func getTracks(playlistId: String) async throws -> [PlaylistTrackObject] {
        let playlistTracksEndpoint = PlaylistTracksEndpoint(id: playlistId)
        let playlistTracksRequest = APIRequest(endpoint: playlistTracksEndpoint, authManager: authManager)
        guard let playlistTracks = try await playlistTracksRequest.executeRequest() else { return []}
        return playlistTracks.items
    }
    
   func getTracksDetails(tracks:[PlaylistTrackObject]) async throws -> Set<TrackFeaturesObject?> {
        let trackIds = tracks.map{ $0.track.id }
        let trackIdsString = trackIds.joined(separator: ",")
        let tracksDetailsEndpoint = TracksDetailEndpoint(ids: trackIdsString)
        
        let tracksDetailsRequest = APIRequest(endpoint: tracksDetailsEndpoint, authManager: authManager)
        guard let trackDetails = try await tracksDetailsRequest.executeRequest() else { return [] }
        return trackDetails.audioFeatures
    }
}

final class PlaylistTracksViewModel: TrackDetailViewFormatter {
    private (set) var playlistTracks:[PlaylistTrackObject] = []
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
    let playlistTracksFetcher:PlaylistTracksFetcherProtocol
    
    init(playlist:PlaylistCellViewModel, playlistTracksFetcher:PlaylistTracksFetcherProtocol = PlaylistTracksFetcher()) {
        self.playlist = playlist
        self.playlistTracksFetcher = playlistTracksFetcher
    }
    
    func getTracks() async throws {
        self.playlistTracks = try await self.playlistTracksFetcher.getTracks(playlistId: self.playlist.id)
        self.trackDetailsArr = try await self.playlistTracksFetcher.getTracksDetails(tracks: self.playlistTracks)
    }
}

