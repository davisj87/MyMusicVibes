//
//  ArtistAlbumsViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/21/23.
//

import Foundation

class ArtistAlbumsViewModel  {
    
    private let authManager = AuthManager()
    private (set) var rows: [AlbumObject] = []
    
    var artistId:String

    init(artistId:String) {
        self.artistId = artistId
    }
    
    func getAlbumsFromArtist() async throws {
        let artistAlbumsEndpoint = ArtistAlbumsEndpoint(id: artistId)
        let artistAlbumsRequest = APIRequest(endpoint: artistAlbumsEndpoint, authManager: authManager)
        guard let artistAlbums = try await artistAlbumsRequest.executeRequest() else { return }
        self.rows = artistAlbums.items
    }
}
