//
//  ResponseWrapper.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/2/23.
//

import Foundation

struct ResponseWrapper<T: Decodable>: Decodable {
    let results: T
}

struct ResponseWrapperArray<T: Decodable>: Decodable {
    let results: [T]
    let totalNumResults: Int?
    
    private enum CodingKeys: String, CodingKey {
        case results
        case totalNumResults = "number_of_total_results"
    }
}
