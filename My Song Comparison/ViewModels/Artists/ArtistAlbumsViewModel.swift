//
//  ArtistAlbumsViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/21/23.
//

import Foundation

class ArtistAlbumsViewModel  {
    
    private let authManager = AuthManager()
    private var albums:[AlbumObject] = []
    
    var albumCount:Int {
        return albums.count
    }
    
    func getAlbumVM(at index:Int) -> AlbumCellViewModel {
        let album = albums[index]
        return AlbumCellViewModel(albumObject: album)
    }
    
    let artist:ArtistCellViewModel

    init(artist:ArtistCellViewModel) {
        self.artist = artist
    }
    
    func getAlbumsFromArtist() async throws {
        let artistAlbumsEndpoint = ArtistAlbumsEndpoint(id: artist.id)
        let artistAlbumsRequest = APIRequest(endpoint: artistAlbumsEndpoint, authManager: authManager)
        guard let artistAlbums = try await artistAlbumsRequest.executeRequest() else { return }
        self.albums = artistAlbums.items
    }
}
