//
//  HomeViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/12/23.
//

import Foundation

class HomeViewModel {
    private let authManager = AuthManager()
    private (set) var sections:[HomeSectionViewModel] = []
    
    func loadTopItems() async throws {
        async let tracks = getTopTracks()
        async let artists = getTopArtists()
        async let playlists = getTopPlaylists()
        self.sections = try await self.getTableViewModel(tracks: tracks, artists: artists, playlist: playlists)
    }
    
    private func getTableViewModel(tracks:[TracksObject], artists:[ArtistObject], playlist: [PlaylistObject]) async -> [HomeSectionViewModel] {
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
    
    private func getTopArtists() async throws -> [ArtistObject] {
        let topArtistsEndpoint = TopArtistsEndpoint()
        let topArtistsRequest = APIRequest(endpoint: topArtistsEndpoint, authManager: authManager)
        
        print("get artists")
        guard let topArtistsWrapper = try await topArtistsRequest.executeRequest() else { return [] }
        print("got artists")
        return topArtistsWrapper.items
    }
    
    private func getTopTracks() async throws -> [TracksObject] {
        let topTracksEndpoint = TopTracksEndpoint()
        let topTracksRequest = APIRequest(endpoint: topTracksEndpoint, authManager: authManager)
        print("get tracks")
        guard let topTracksWrapper = try await topTracksRequest.executeRequest() else { return [] }
        print("got tracks")
        return topTracksWrapper.items
    }
    
    private func getTopPlaylists() async throws -> [PlaylistObject] {
        let topPlaylistsEndpoint = TopPlaylistsEndpoint()
        let topPlaylistsRequest = APIRequest(endpoint: topPlaylistsEndpoint, authManager: authManager)
        print("get playlists")
        guard let topPlaylistsWrapper = try await topPlaylistsRequest.executeRequest() else { return [] }
        print("got playlists")
        return topPlaylistsWrapper.items
    }
    
}


