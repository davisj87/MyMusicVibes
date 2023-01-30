//
//  HomeTableViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/30/23.
//

import Foundation

enum HomeSectionViewModelScope:String {
    case artist = "Artist"
    case track = "Track"
    case playlist = "Playlist"
}

struct HomeSectionViewModel {
    var title:HomeSectionViewModelScope
    var homeCells:[ItemOverviewCellViewModelProtocol]
}
