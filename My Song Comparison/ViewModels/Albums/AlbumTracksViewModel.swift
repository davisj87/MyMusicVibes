//
//  AlbumTracksViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/22/23.
//

import Foundation

class AlbumTracksViewModel: TrackDetailViewModelHelper  {
    
    private let authManager = AuthManager()
    private (set) var rows:[TrackListViewModel] = []
    
    private (set) var album:AlbumObject

    init(album:AlbumObject) {
        self.album = album
    }
    
    func getAlbumTracks() async throws {
        let albumTracksEndpoint = AlbumTracksEndpoint(id: self.album.id)
        let albumTracksRequest = APIRequest(endpoint: albumTracksEndpoint, authManager: authManager)
        guard let albumTracks = try await albumTracksRequest.executeRequest() else { return }
        let trackIds = albumTracks.items.map{ $0.id }
        let trackIdsString = trackIds.joined(separator: ",")
        
        let trackArr = try await self.getTracksArray(ids: trackIdsString)
        let trackDetailsArr = try await self.getTracksDetails(ids: trackIdsString)
        
        self.rows = await self.setupAlbumTracksTableViewModel(tracks: trackArr, tracksDetails: trackDetailsArr)
    }
    
    private func getTracksDetails(ids:String) async throws -> [TrackFeaturesObject]{
        let tracksDetailsEndpoint = TracksDetailEndpoint(ids: ids)
        let tracksDetailsRequest = APIRequest(endpoint: tracksDetailsEndpoint, authManager: authManager)
        guard let trackDetails = try await tracksDetailsRequest.executeRequest() else { return [] }
        
        return trackDetails.audioFeatures
    }
    
    private func getTracksArray(ids:String) async throws -> [TracksObject] {
        let tracksArrEndpoint = TracksArrayEndpoint(ids: ids)
        let tracksArrRequest = APIRequest(endpoint: tracksArrEndpoint, authManager: authManager)
        print("get tracks")
        guard let tracksArr = try await tracksArrRequest.executeRequest() else { return [] }
        print("got tracks")
        return tracksArr.tracks
    }
    
    private func setupAlbumTracksTableViewModel(tracks:[TracksObject], tracksDetails:[TrackFeaturesObject]) async -> [TrackListViewModel] {

        var trackDict:[String:TracksObject] = [:]
        for eachTrack in tracks {
            trackDict[eachTrack.id] = eachTrack
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
