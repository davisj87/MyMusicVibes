//
//  SearchCellViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import Foundation

struct SearchAlbumCellViewModel: ItemOverviewCellViewModelProtocol {
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

