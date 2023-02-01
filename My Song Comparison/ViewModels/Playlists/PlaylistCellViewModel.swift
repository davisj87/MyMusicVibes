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
    
    init(playlistObject: PlaylistObject) {
        self.id = playlistObject.id
        self.primaryText = playlistObject.name
        self.secondaryText = playlistObject.owner.name
        self.additionalDetailText = ""
        self.imageUrl = playlistObject.images.isEmpty ? "" : playlistObject.images[0].url
    }
}
