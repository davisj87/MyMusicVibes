//
//  AlbumCellViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/30/23.
//

import Foundation

struct AlbumCellViewModel {
    var id:String
    var name:String
    var releaseDate:String
    var imageUrl:String = ""
    
    init(albumObject:AlbumObject) {
        self.id = albumObject.id
        self.name = albumObject.name
        self.releaseDate = "Released: " + albumObject.releaseDate
        guard !albumObject.images.isEmpty else { return }
        self.imageUrl = albumObject.images[0].url
    }
}
