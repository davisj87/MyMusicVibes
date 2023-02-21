//
//  SearchViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import Foundation

final class SearchViewModel {
    private (set) var isSearching:Bool = false
    
    private (set) var currentSearchScope:SearchType = .all
    private (set) var currentScopeTotal:Int = 0
    
    private var currentScopeCountOffset:Int {
        if self.currentSearchScope == .all {
            return 0
        }
        return self.searchViewModelCells.count
    }
    
    private var currentQuery:String = ""
    
    private let authManager = AuthManager()
    var searchViewModelCells:[ItemOverviewCellViewModelProtocol] = []
    
    func searchMusic(type:String, query:String) async throws {
        guard !isSearching else { return }
        guard let filter = SearchType(rawValue: type) else { return }
        self.currentSearchScope = filter
        self.currentQuery = query
        self.isSearching = true
        switch filter {
        case .all:
            self.searchViewModelCells = try await self.getAll(query: query)
        case .album:
            self.searchViewModelCells = try await self.getAlbum(query: query, limit: 20, offset: 0)
        case .artist:
            self.searchViewModelCells = try await self.getArtists(query: query, limit: 20, offset: 0)
        case .playlist:
            self.searchViewModelCells = try await self.getPlaylists(query: query, limit: 20, offset: 0)
        case .track:
            self.searchViewModelCells = try await self.getTracks(query: query, limit: 20, offset: 0)
     
        }
        self.isSearching = false
    }
    
    func searchMoreMusic() async throws {
        guard !isSearching else { return }
        self.isSearching = true
        switch self.currentSearchScope {
        case .all:
            break
        case .album:
            let additionalAlbums = try await self.getAlbum(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalAlbums)
        case .artist:
            let additionalArtists = try await self.getArtists(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalArtists)
        case .playlist:
            let additionalPlaylists = try await self.getPlaylists(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalPlaylists)
        case .track:
            let additionalTracks = try await self.getTracks(query: currentQuery, limit: 20, offset: self.currentScopeCountOffset)
            self.searchViewModelCells.append(contentsOf: additionalTracks)
     
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
    
    private func getAlbum(query:String, limit:Int, offset:Int) async throws -> [AlbumCellViewModel] {
        let searchAlbumEndpoint = SearchAlbumEndpoint(searchString: query, limit: limit, offset: offset)
        let searchAlbumRequest = APIRequest(endpoint: searchAlbumEndpoint, authManager: authManager)
        guard let searchAlbumResults = try await searchAlbumRequest.executeRequest() else { return []}
        let albums = searchAlbumResults.albums.items
        self.currentScopeTotal = searchAlbumResults.albums.total
        return albums.map{ AlbumCellViewModel(albumObject: $0) }
    }
    
    private func getArtists(query:String, limit:Int, offset:Int) async throws -> [ArtistCellViewModel] {
        let searchArtistEndpoint = SearchArtistEndpoint(searchString: query, limit: limit, offset: offset)
        let searchArtistRequest = APIRequest(endpoint: searchArtistEndpoint, authManager: authManager)
        guard let searchArtistResults = try await searchArtistRequest.executeRequest() else { return []}
        let artists = searchArtistResults.artists.items
        self.currentScopeTotal = searchArtistResults.artists.total
        return artists.map{ ArtistCellViewModel(artistsObject:$0) }
    }
    
    private func getPlaylists(query:String, limit:Int, offset:Int) async throws -> [PlaylistCellViewModel] {
        let searchPlaylistEndpoint = SearchPlaylistEndpoint(searchString: query, limit: limit, offset: offset)
        let searchPlaylistRequest = APIRequest(endpoint: searchPlaylistEndpoint, authManager: authManager)
        guard let searchPlaylistResults = try await searchPlaylistRequest.executeRequest() else { return []}
        let playlists = searchPlaylistResults.playlists.items
        self.currentScopeTotal = searchPlaylistResults.playlists.total
        return playlists.map{ PlaylistCellViewModel(playlistObject: $0) }
    }
    
    private func getTracks(query:String, limit:Int, offset:Int) async throws -> [TrackCellViewModel] {
        let searchTrackEndpoint = SearchTrackEndpoint(searchString: query, limit: limit, offset: offset)
        let searchTrackRequest = APIRequest(endpoint: searchTrackEndpoint, authManager: authManager)
        guard let searchTrackResults = try await searchTrackRequest.executeRequest() else { return []}
        let tracks = searchTrackResults.tracks.items
        self.currentScopeTotal = searchTrackResults.tracks.total
        return tracks.map{ TrackCellViewModel(tracksObject: $0) }
    }
}
