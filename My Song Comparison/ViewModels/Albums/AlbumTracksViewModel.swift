//
//  AlbumTracksViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/22/23.
//

import Foundation

final class AlbumTracksViewModel {
    
    private let authManager = AuthManager()
    private (set) var tracks:[TracksObject] = []
    private (set) var trackDetails = Set<TrackFeaturesObject?>()
    private let albumTracksFetcher:AlbumTracksFetcherProtocol
    let album:ItemOverviewCellViewModelProtocol
    
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

    
    init(album:ItemOverviewCellViewModelProtocol, albumTracksFetcher:AlbumTracksFetcherProtocol = AlbumTracksFetcher()) {
        self.album = album
        self.albumTracksFetcher = albumTracksFetcher
    }
    
    func getTracksData() async throws {
        let trackIdsString = try await self.albumTracksFetcher.getAlbumTracks(albumId: self.album.id)
        async let trackArr = self.albumTracksFetcher.getTracks(ids: trackIdsString)
        async let trackDetailsArr = self.albumTracksFetcher.getTracksDetails(ids: trackIdsString)
        let result = try await TrackAndDetailsResponse(tracks: trackArr, trackDetails: trackDetailsArr)
        self.tracks = result.tracks
        self.trackDetails = result.trackDetails
    }
}


fileprivate struct TrackAndDetailsResponse {
    var tracks:[TracksObject]
    var trackDetails:Set<TrackFeaturesObject?>
}
