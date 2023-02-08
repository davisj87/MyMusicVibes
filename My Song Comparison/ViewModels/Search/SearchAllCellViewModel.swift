//
//  SearchCellViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import Foundation

struct SearchAllCellViewModel: ItemOverviewCellViewModelProtocol {
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String = ""
    var popularity: String = ""
    var imageUrl:String = ""
    var id:String
    
    init(albumObject:AlbumObject) {
        self.id = albumObject.id
        self.primaryText = albumObject.name
        self.secondaryText = albumObject.artists.isEmpty ? "" : albumObject.artists[0].name
        self.additionalDetailText = albumObject.releaseDate
        self.imageUrl = albumObject.images.isEmpty ? "" : albumObject.images[0].url
    }
}

