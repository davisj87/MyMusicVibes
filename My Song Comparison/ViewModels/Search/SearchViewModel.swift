//
//  SearchViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import Foundation

class SearchViewModel {
    
    private let authManager = AuthManager()
    var searchViewModelCells:[ItemOverviewCellViewModelProtocol] = []
    
    func searchMusic(type:String, query:String) async throws {
        self.searchViewModelCells = []
        let filter = SearchType(rawValue: type)
        switch filter {
        case .album:
            self.searchViewModelCells = try await self.getAlbum(query: query)
        case .artist:
            self.searchViewModelCells = try await self.getArtists(query: query)
        case .playlist:
            self.searchViewModelCells = try await self.getPlaylists(query: query)
        case .track:
            self.searchViewModelCells = try await self.getTracks(query: query)
            return
        default:
            return
        }
    }
    
    private func getAlbum(query:String) async throws -> [SearchAlbumCellViewModel] {
        let searchAlbumEndpoint = SearchAlbumEndpoint(searchString: query)
        let searchAlbumRequest = APIRequest(endpoint: searchAlbumEndpoint, authManager: authManager)
        guard let searchAlbumResults = try await searchAlbumRequest.executeRequest() else { return []}
        let albums = searchAlbumResults.albums.items
        return albums.map{ SearchAlbumCellViewModel(albumListObject: $0) }
    }
    
    private func getArtists(query:String) async throws -> [SearchArtistCellViewModel] {
        let searchArtistEndpoint = SearchArtistEndpoint(searchString: query)
        let searchArtistRequest = APIRequest(endpoint: searchArtistEndpoint, authManager: authManager)
        guard let searchArtistResults = try await searchArtistRequest.executeRequest() else { return []}
        let artists = searchArtistResults.artists.items
        return artists.map{ SearchArtistCellViewModel(artistListObject: $0) }
    }
    
    private func getPlaylists(query:String) async throws -> [SearchPlaylistCellViewModel] {
        let searchPlaylistEndpoint = SearchPlaylistEndpoint(searchString: query)
        let searchPlaylistRequest = APIRequest(endpoint: searchPlaylistEndpoint, authManager: authManager)
        guard let searchPlaylistResults = try await searchPlaylistRequest.executeRequest() else { return []}
        let playlists = searchPlaylistResults.playlists.items
        return playlists.map{ SearchPlaylistCellViewModel(playlistListObject: $0) }
    }
    
    private func getTracks(query:String) async throws -> [SearchTrackCellViewModel] {
        let searchTrackEndpoint = SearchTrackEndpoint(searchString: query)
        let searchTrackRequest = APIRequest(endpoint: searchTrackEndpoint, authManager: authManager)
        guard let searchTrackResults = try await searchTrackRequest.executeRequest() else { return []}
        let tracks = searchTrackResults.tracks.items
        return tracks.map{ SearchTrackCellViewModel(trackObject: $0) }
    }
}
