//
//  ItemOverviewViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/30/23.
//

import Foundation

// Use this protocol for the view models that give a small overview of an item.
// TableViewCell and HeaderViews for Albums, Artists, PLaylists, and Tracks should all use this protocol


protocol ItemOverviewCellViewModelProtocol {
    var primaryText:String { get }
    var secondaryText:String { get }
    var additionalDetailText:String { get }
    var popularity:String { get }
    var imageUrl:String { get }
    var id:String { get }
}
