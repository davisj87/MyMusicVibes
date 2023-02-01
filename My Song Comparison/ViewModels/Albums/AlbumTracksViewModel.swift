//
//  AlbumTracksViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/22/23.
//

import Foundation

class AlbumTracksViewModel {
    
    private let authManager = AuthManager()
    private var tracks:[TracksObject] = []
    private var trackDetails = Set<TrackFeaturesObject?>()
    let album:AlbumCellViewModel

    var trackCount:Int {
        return tracks.count
    }
    
    func getTrackAndDetailsVM(at index:Int) -> TrackDetailTableViewCellViewModel {
        let track = tracks[index]
        let trackCellViewModel = TrackCellViewModel(tracksObject: track)
        if let detailIndex = trackDetails.firstIndex(of: TrackFeaturesObject(withId: track.id)) {
            return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: trackDetails[detailIndex])
        }
        return TrackDetailTableViewCellViewModel(track: trackCellViewModel, trackDetail: nil)
    }

    
    init(album:AlbumCellViewModel) {
        self.album = album
    }
    
    func getAlbumTracks() async throws {
        let albumTracksEndpoint = AlbumTracksEndpoint(id: self.album.id)
        let albumTracksRequest = APIRequest(endpoint: albumTracksEndpoint, authManager: authManager)
        guard let albumTracks = try await albumTracksRequest.executeRequest() else { return }
        let trackIds = albumTracks.items.map{ $0.id }
        let trackIdsString = trackIds.joined(separator: ",")
        
        async let trackArr = self.getTracksArray(ids: trackIdsString)
        async let trackDetailsArr = self.getTracksDetails(ids: trackIdsString)
        let result = try await TrackAndDetailsResponse(tracks: trackArr, trackDetails: trackDetailsArr)
        self.tracks = result.tracks
        self.trackDetails = result.trackDetails
    }
    
    private func getTracksDetails(ids:String) async throws -> Set<TrackFeaturesObject?> {
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
}


fileprivate struct TrackAndDetailsResponse {
    var tracks:[TracksObject]
    var trackDetails:Set<TrackFeaturesObject?>
}
