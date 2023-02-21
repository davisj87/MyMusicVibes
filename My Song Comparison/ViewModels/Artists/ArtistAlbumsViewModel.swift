//
//  ArtistAlbumsViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/21/23.
//

import Foundation

final class ArtistAlbumsViewModel  {
    private var isPaginating:Bool = false
    private let authManager = AuthManager()
    private var albums:[AlbumObject] = []
    private (set) var albumTotal:Int = 0
    
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
        let artistAlbumsEndpoint = ArtistAlbumsEndpoint(id: artist.id, limit: 20, offset: 0)
        let artistAlbumsRequest = APIRequest(endpoint: artistAlbumsEndpoint, authManager: authManager)
        guard let artistAlbums = try await artistAlbumsRequest.executeRequest(),
        artistAlbums.total > 0 else { return }
        
        self.albumTotal = artistAlbums.total
        self.albums = artistAlbums.items
    }
    
    func getMoreAlbumsFromArtist() async throws {
        guard self.albumTotal > self.albums.count else { return }
        if !isPaginating {
            self.isPaginating = true
            let artistAlbumsEndpoint = ArtistAlbumsEndpoint(id: artist.id, limit: 20, offset: self.albumCount)
            let artistAlbumsRequest = APIRequest(endpoint: artistAlbumsEndpoint, authManager: authManager)
            guard let artistAlbums = try await artistAlbumsRequest.executeRequest(), artistAlbums.total > 0 else { return }
            
            self.albums.append(contentsOf: artistAlbums.items)
            self.isPaginating = false
        }
    }
    
    
}
