//
//  HomeTableViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/30/23.
//

import Foundation

struct HomeSectionViewModel {
    var title:String
    var homeCells:[ItemOverviewCellViewModelProtocol]
}



struct TopArtistsCellViewModel: ItemOverviewCellViewModelProtocol {
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var imageUrl: String
    var id: String
    
    init(topArtistsObject: TopArtistsObject) {
        self.id = topArtistsObject.id
        self.primaryText = topArtistsObject.name
        self.secondaryText = ""
        if !topArtistsObject.genres.isEmpty {
            let genres = topArtistsObject.genres.joined(separator: ", ")
            self.secondaryText = genres
        }
        self.additionalDetailText = "Pop:\n \(topArtistsObject.popularity)"
        self.imageUrl = topArtistsObject.images.isEmpty ? "" : topArtistsObject.images[0].url
    }
}

struct TopTracksCellViewModel: ItemOverviewCellViewModelProtocol {
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var imageUrl: String
    var id: String
    
    init(topTracksObject: TracksObject) {
        self.id = topTracksObject.id
        self.primaryText = topTracksObject.name
        self.secondaryText = topTracksObject.artists.isEmpty ? "" : topTracksObject.artists[0].name
        self.additionalDetailText = "Pop:\n \(topTracksObject.popularity)"
        self.imageUrl = topTracksObject.album.images.isEmpty ? "" : topTracksObject.album.images[0].url
    }
}

struct TopPlaylistCellViewModel: ItemOverviewCellViewModelProtocol {
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var imageUrl: String
    var id: String
    
    init(topPlaylistObject: TopPlaylistsObject) {
        self.id = topPlaylistObject.id
        self.primaryText = topPlaylistObject.name
        self.secondaryText = topPlaylistObject.owner.name
        self.additionalDetailText = ""
        self.imageUrl = topPlaylistObject.images.isEmpty ? "" : topPlaylistObject.images[0].url
    }
}
