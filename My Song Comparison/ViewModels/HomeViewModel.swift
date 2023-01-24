//
//  HomeViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/12/23.
//

import Foundation

class HomeViewModel {
    private let authManager = AuthManager()
    private (set) var topItems:HomeViewModelTopItems = HomeViewModelTopItems(topArtists: [], topTracks: [], topPlaylists: [])
    
    
    func loadTopItems() async throws {
        async let tracks = getTopTracks()
        async let artists = getTopArtists()
        async let playlists = getTopPlaylists()
        self.topItems = try await HomeViewModelTopItems(topArtists: artists, topTracks: tracks, topPlaylists: playlists)
    }
    
    private func getTopArtists() async throws -> [TopArtistsObject] {
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
    
    private func getTopPlaylists() async throws -> [TopPlaylistsObject] {
        let topPlaylistsEndpoint = TopPlaylistsEndpoint()
        let topPlaylistsRequest = APIRequest(endpoint: topPlaylistsEndpoint, authManager: authManager)
        print("get playlists")
        guard let topPlaylistsWrapper = try await topPlaylistsRequest.executeRequest() else { return [] }
        print("got playlists")
        return topPlaylistsWrapper.items
    }
    
}

extension HomeViewModel {
    struct HomeViewModelTopItems {
        let topArtists:[TopArtistsObject]
        let topTracks:[TracksObject]
        let topPlaylists:[TopPlaylistsObject]
    }
}
