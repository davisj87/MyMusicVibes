//
//  SearchViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import Foundation

class SearchViewModel {
    
    private let authManager = AuthManager()
    var searchViewModelCells:[SearchCellViewModel] = []
    
    func searchMusic(type:String, query:String) async throws {
        let filter = SearchType(rawValue: type)
        switch filter {
        case .album:
            self.searchViewModelCells = try await self.getAlbum(query: query)
        case .artist:
            return
        case .track:
            return
        case .genre:
            return
        default:
            return
        }
//        let playlistTracksEndpoint = PlaylistTracksEndpoint(id: id)
//        let playlistTracksRequest = APIRequest(endpoint: playlistTracksEndpoint, authManager: authManager)
//        guard let playlistTracks = try await playlistTracksRequest.executeRequest() else { return }
//        self.playlistTracks = playlistTracks.items
//        self.trackDetails = try await self.getTracksDetails(tracks: playlistTracks.items)
    }
    
    private func getAlbum(query:String) async throws -> [SearchCellViewModel] {
        let searchAlbumEndpoint = SearchAlbumEndpoint(searchString: query)
        let searchAlbumRequest = APIRequest(endpoint: searchAlbumEndpoint, authManager: authManager)
        guard let searchAlbumResults = try await searchAlbumRequest.executeRequest() else { return []}
        let albums = searchAlbumResults.albums.items
        var tempAlbumCells:[SearchCellViewModel] = []
        for eachAlbum in albums {
            let name = eachAlbum.name
            let id = eachAlbum.id
            let artist = eachAlbum.artists.isEmpty ? "" : eachAlbum.artists[0].name
            let imageUrl = eachAlbum.images.isEmpty ? "" : eachAlbum.images[0].url
            let searchCell = SearchCellViewModel(primaryText: name, secondaryText: artist, imageUrl: imageUrl, id: id)
            tempAlbumCells.append(searchCell)
        }
        return tempAlbumCells
    }
}
