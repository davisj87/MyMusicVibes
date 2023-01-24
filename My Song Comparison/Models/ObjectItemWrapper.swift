//
//  UserItemWrapper.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/12/23.
//

import Foundation

struct ObjectItemWrapper<T: Decodable>: Decodable {
    let items: [T]
    let total: Int?
}
