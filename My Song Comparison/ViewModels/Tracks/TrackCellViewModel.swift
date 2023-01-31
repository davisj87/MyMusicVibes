//
//  TrackCellViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/30/23.
//

import Foundation

struct TrackCellViewModel: ItemOverviewCellViewModelProtocol {
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String = ""
    var popularity: String
    var imageUrl: String
    var id: String
    
    init(topTracksObject: TracksObject) {
        self.id = topTracksObject.id
        self.primaryText = topTracksObject.name
        self.secondaryText = topTracksObject.artists.isEmpty ? "" : topTracksObject.artists[0].name
        self.additionalDetailText = topTracksObject.album.name
        self.popularity = "Pop:\n \(topTracksObject.popularity)"
        self.imageUrl = topTracksObject.album.images.isEmpty ? "" : topTracksObject.album.images[0].url
    }
}
