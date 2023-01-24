//
//  AuthorizedEndpoint.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/6/23.
//

import Foundation

enum PayloadEncodingMethod: String {
    case formUrl = "application/x-www-form-urlencoded"
    case json = "application/json"
}

protocol AuthorizedEndpoint: Endpoint {}

extension AuthorizedEndpoint {
    var requiresAuth: Bool {
        return true
    }
}
