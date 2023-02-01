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
    
    init(tracksObject: TracksObject) {
        self.id = tracksObject.id
        self.primaryText = tracksObject.name
        self.secondaryText = tracksObject.artists.isEmpty ? "" : tracksObject.artists[0].name
        self.additionalDetailText = tracksObject.album.name
        self.popularity = String(tracksObject.popularity)
        self.imageUrl = tracksObject.album.images.isEmpty ? "" : tracksObject.album.images[0].url
    }
}
