//
//  HomeViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/12/23.
//

import Foundation

final class HomeViewModel {
    private let authManager = AuthManager()
    private (set) var sections:[HomeSectionViewModel] = []
    
    let homeFetcher:HomeFetcherProtocol
    
    init(homeFetcher: HomeFetcherProtocol = HomeFetcher()) {
        self.homeFetcher = homeFetcher
    }
    
    func loadTopItems() async throws {
        async let tracks = self.homeFetcher.getTopTracks()
        async let artists = self.homeFetcher.getTopArtists()
        async let playlists = self.homeFetcher.getTopPlaylists()
        self.sections = try await self.getTableViewModel(tracks: tracks, artists: artists, playlist: playlists)
    }
    
    private func getTableViewModel(tracks:[TracksObject], artists:[ArtistObject], playlist: [PlaylistObject]) -> [HomeSectionViewModel] {
        let tracksViewModel = tracks.map{ TrackCellViewModel(tracksObject: $0) }
        let artistViewModel = artists.map{ ArtistCellViewModel(artistsObject: $0) }
        let playlistViewModel = playlist.map{ PlaylistCellViewModel(playlistObject: $0) }
        
        var sectionViewModelArr:[HomeSectionViewModel] = []
        if !artistViewModel.isEmpty {
            let artistSection = HomeSectionViewModel(title: .artist, homeCells: artistViewModel)
            sectionViewModelArr.append(artistSection)
        }
        if !tracksViewModel.isEmpty {
            let tracksSection = HomeSectionViewModel(title: .track, homeCells: tracksViewModel)
            sectionViewModelArr.append(tracksSection)
        }
        if !playlistViewModel.isEmpty {
            let playlistSection = HomeSectionViewModel(title: .playlist, homeCells: playlistViewModel)
            sectionViewModelArr.append(playlistSection)
        }
        
        return sectionViewModelArr
    }
}


