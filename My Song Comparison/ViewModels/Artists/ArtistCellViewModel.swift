//
//  ArtistCellViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/30/23.
//

import Foundation

struct ArtistCellViewModel: ItemOverviewCellViewModelProtocol {
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String = ""
    var popularity: String
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
        self.popularity = "Pop:\n \(topArtistsObject.popularity)"
        self.imageUrl = topArtistsObject.images.isEmpty ? "" : topArtistsObject.images[0].url
    }
}
