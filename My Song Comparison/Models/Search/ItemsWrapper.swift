//
//  ItemsWrapper.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/7/23.
//

import Foundation

//Generic wrapper to handle items returned by search api for album, artist, playlist, and track wrappers

struct ItemsWrapper<T:Decodable>: Decodable {
    var items: [T]
}
