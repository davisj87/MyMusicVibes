//
//  PlaylistTracksViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/19/23.
//

import Foundation


class PlaylistTracksViewModel: TrackDetailViewModelHelper {
    
    private let authManager = AuthManager()
    private (set) var rows:[TrackListViewModel] = []
    
    var id:String
    
    init(id:String) {
        self.id = id
    }
    
    func getTracks() async throws {
        let playlistTracksEndpoint = PlaylistTracksEndpoint(id: id)
        let playlistTracksRequest = APIRequest(endpoint: playlistTracksEndpoint, authManager: authManager)
        guard let playlistTracks = try await playlistTracksRequest.executeRequest() else { return }
        try await self.getTracksDetails(tracks: playlistTracks.items)

    }
    
    private func getTracksDetails(tracks:[PlaylistTrackObject]) async throws {
        let trackIds = tracks.map{ $0.track.id }
        let trackIdsString = trackIds.joined(separator: ",")
        let tracksDetailsEndpoint = TracksDetailEndpoint(ids: trackIdsString)
        
        let tracksDetailsRequest = APIRequest(endpoint: tracksDetailsEndpoint, authManager: authManager)
        guard let trackDetails = try await tracksDetailsRequest.executeRequest() else { return }
        self.rows = await self.setupPlaylistTableViewModel(tracks: tracks, tracksDetails: trackDetails.audioFeatures)
    }
    
    private func setupPlaylistTableViewModel(tracks:[PlaylistTrackObject], tracksDetails:[TrackFeaturesObject]) async -> [TrackListViewModel] {

        var trackDict:[String:TracksObject] = [:]
        for eachTrack in tracks {
            trackDict[eachTrack.track.id] = eachTrack.track
        }
        var tempTrackListViewModelArr:[TrackListViewModel] = []
        for eachTrackDetail in tracksDetails {
            if let trackInfo = trackDict[eachTrackDetail.id] {
                let valenceString = self.intValencetoString(valence: eachTrackDetail.valence)
                let keyString = self.intKeytoString(key: eachTrackDetail.key)
                let modeString = self.intModetoString(mode: eachTrackDetail.mode)
                let keyMode =  keyString + " " + modeString
                let danceability = String(Int(eachTrackDetail.danceability))
                let detailsShort = TrackFeaturesObjectShort(danceability: danceability, keyMode: keyMode, valence: valenceString)
                let playlistTrack = TrackListViewModel(track: trackInfo, details: eachTrackDetail, detailsShort: detailsShort)
                tempTrackListViewModelArr.append(playlistTrack)
            }
        }
        return tempTrackListViewModelArr
    }
}

struct TrackListViewModel {
    var track:TracksObject
    var details:TrackFeaturesObject
    var detailsShort: TrackFeaturesObjectShort
}

struct TrackFeaturesObjectShort {
    var danceability: String
    var keyMode: String
    var valence: String
}

