//
//  ArtistAlbumsViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/21/23.
//

import Foundation

final class ArtistAlbumsViewModel  {
    private var isPaginating:Bool = false
    private var albums:[AlbumObject] = []
    private (set) var albumTotal:Int = 0
    
    var albumCount:Int {
        return albums.count
    }
    
    func getAlbumVM(at index:Int) -> AlbumCellViewModel {
        let album = albums[index]
        return AlbumCellViewModel(albumObject: album)
    }
    
    let artist:ItemOverviewCellViewModelProtocol
    private let artistAlbumsFetcher:ArtistAlbumsFetcherProtocol
    
    init(artist:ItemOverviewCellViewModelProtocol, artistAlbumsFetcher:ArtistAlbumsFetcherProtocol = ArtistAlbumsFetcher()) {
        self.artist = artist
        self.artistAlbumsFetcher = artistAlbumsFetcher
    }
    
    func getAlbumData() async throws {
        let albumData = try await self.artistAlbumsFetcher.getAlbumsFromArtist(artistId: self.artist.id)
        self.albumTotal = albumData.total
        self.albums = albumData.items
    }
    
    func getMoreAlbumData() async throws {
        defer { self.isPaginating = false }
        guard self.albumTotal > self.albums.count else { return }
        if !isPaginating {
            self.isPaginating = true
            let moreAlbumData = try await self.artistAlbumsFetcher.getMoreAlbumsFromArtist(artistId: self.artist.id, offset: self.albumCount)
            guard !moreAlbumData.isEmpty else { return }
            self.albums.append(contentsOf: moreAlbumData)
        }
    }
}
