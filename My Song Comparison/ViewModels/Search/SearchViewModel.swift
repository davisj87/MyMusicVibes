//
//  SearchViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import Foundation

class SearchViewModel {
    private (set) var isSearching:Bool = false
    private let authManager = AuthManager()
    var searchViewModelCells:[ItemOverviewCellViewModelProtocol] = []
    
    func searchMusic(type:String, query:String) async throws {
        guard !isSearching else { return }
        guard let filter = SearchType(rawValue: type) else { return }
        self.isSearching = true
        self.searchViewModelCells = []
        switch filter {
        case .all:
            self.searchViewModelCells = try await self.getAll(query: query)
        case .album:
            self.searchViewModelCells = try await self.getAlbum(query: query)
        case .artist:
            self.searchViewModelCells = try await self.getArtists(query: query)
        case .playlist:
            self.searchViewModelCells = try await self.getPlaylists(query: query)
        case .track:
            self.searchViewModelCells = try await self.getTracks(query: query)
     
        }
        self.isSearching = false
    }
    
    
    private func getAll(query:String) async throws -> [SearchAllCellViewModel] {
        let searchAllEndpoint = SearchAllEndpoint(searchString: query)
        let searchAllRequest = APIRequest(endpoint: searchAllEndpoint, authManager: authManager)
        guard let searchAllResults = try await searchAllRequest.executeRequest() else { return []}
        let albums = searchAllResults.albums.items
        let albumCellVM = albums.map{ SearchAllCellViewModel(albumObject: $0) }
        let playlists = searchAllResults.playlists.items
        let playlistCellVM = playlists.map{ SearchAllCellViewModel(playlistObject: $0) }
        let tracks = searchAllResults.tracks.items
        let tracksCellVM = tracks.map{ SearchAllCellViewModel(tracksObject: $0) }
        let artists = searchAllResults.artists.items
        let artistCellVM = artists.map{ SearchAllCellViewModel(artistsObject:$0) }
        
        return albumCellVM + playlistCellVM + tracksCellVM + artistCellVM
    }
    
    private func getAlbum(query:String) async throws -> [AlbumCellViewModel] {
        let searchAlbumEndpoint = SearchAlbumEndpoint(searchString: query)
        let searchAlbumRequest = APIRequest(endpoint: searchAlbumEndpoint, authManager: authManager)
        guard let searchAlbumResults = try await searchAlbumRequest.executeRequest() else { return []}
        let albums = searchAlbumResults.albums.items
        return albums.map{ AlbumCellViewModel(albumObject: $0) }
    }
    
    private func getArtists(query:String) async throws -> [ArtistCellViewModel] {
        let searchArtistEndpoint = SearchArtistEndpoint(searchString: query)
        let searchArtistRequest = APIRequest(endpoint: searchArtistEndpoint, authManager: authManager)
        guard let searchArtistResults = try await searchArtistRequest.executeRequest() else { return []}
        let artists = searchArtistResults.artists.items
        return artists.map{ ArtistCellViewModel(artistsObject:$0) }
    }
    
    private func getPlaylists(query:String) async throws -> [PlaylistCellViewModel] {
        let searchPlaylistEndpoint = SearchPlaylistEndpoint(searchString: query)
        let searchPlaylistRequest = APIRequest(endpoint: searchPlaylistEndpoint, authManager: authManager)
        guard let searchPlaylistResults = try await searchPlaylistRequest.executeRequest() else { return []}
        let playlists = searchPlaylistResults.playlists.items
        return playlists.map{ PlaylistCellViewModel(playlistObject: $0) }
    }
    
    private func getTracks(query:String) async throws -> [TrackCellViewModel] {
        let searchTrackEndpoint = SearchTrackEndpoint(searchString: query)
        let searchTrackRequest = APIRequest(endpoint: searchTrackEndpoint, authManager: authManager)
        guard let searchTrackResults = try await searchTrackRequest.executeRequest() else { return []}
        let tracks = searchTrackResults.tracks.items
        return tracks.map{ TrackCellViewModel(tracksObject: $0) }
    }
}
