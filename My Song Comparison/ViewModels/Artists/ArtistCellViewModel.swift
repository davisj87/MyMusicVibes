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
    
    init(artistsObject: ArtistObject) {
        self.id = artistsObject.id
        self.primaryText = artistsObject.name
        self.secondaryText = ""
        if !artistsObject.genres.isEmpty {
            let genres = artistsObject.genres.joined(separator: ", ")
            self.secondaryText = genres
        }
        self.popularity = "Pop:\n \(artistsObject.popularity)"
        self.imageUrl = artistsObject.images.isEmpty ? "" : artistsObject.images[0].url
    }
}
