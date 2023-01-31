//
//  PlaylistCellViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/30/23.
//

import Foundation

struct PlaylistCellViewModel: ItemOverviewCellViewModelProtocol {
    var primaryText: String
    var secondaryText: String
    var additionalDetailText: String
    var popularity: String = ""
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
