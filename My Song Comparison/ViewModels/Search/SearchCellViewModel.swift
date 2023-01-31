//
//  SearchCellViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import Foundation

struct SearchAlbumCellViewModel: ItemOverviewCellViewModelProtocol {
    var popularity: String = ""
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var imageUrl: String
    var id: String
    
    init(albumListObject: AlbumListObject) {
        self.id = albumListObject.id
        self.primaryText = albumListObject.name
        self.secondaryText = albumListObject.artists.isEmpty ? "" : albumListObject.artists[0].name
        self.additionalDetailText = ""
        self.imageUrl = albumListObject.images.isEmpty ? "" : albumListObject.images[0].url
    }
}

struct SearchArtistCellViewModel: ItemOverviewCellViewModelProtocol {
    var popularity: String = ""
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var imageUrl: String
    var id: String
    
    init(artistListObject: ArtistObject) {
        self.id = artistListObject.id
        self.primaryText = artistListObject.name
        self.secondaryText = "Followers: \(artistListObject.followers.total)"
        self.additionalDetailText = ""
        self.imageUrl = artistListObject.images.isEmpty ? "" : artistListObject.images[0].url
    }
}

struct SearchPlaylistCellViewModel: ItemOverviewCellViewModelProtocol {
    var popularity: String = ""
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var imageUrl: String
    var id: String
    
    init(playlistListObject: PlaylistListObject) {
        self.id = playlistListObject.id
        self.primaryText = playlistListObject.name
        self.secondaryText = playlistListObject.owner.name
        self.additionalDetailText = ""
        self.imageUrl = playlistListObject.images.isEmpty ? "" : playlistListObject.images[0].url
    }
}

struct SearchTrackCellViewModel: ItemOverviewCellViewModelProtocol {
    var popularity: String = ""
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var imageUrl: String
    var id: String
    
    init(trackObject: TracksObject) {
        self.id = trackObject.id
        self.primaryText = trackObject.name
        self.secondaryText = trackObject.artists.isEmpty ? "" : trackObject.artists[0].name
        self.additionalDetailText = ""
        self.imageUrl = trackObject.album.images.isEmpty ? "" : trackObject.album.images[0].url
    }
}

