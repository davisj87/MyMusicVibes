//
//  RequestError.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/2/23.
//

enum RequestError: Error {
    case decode
    case invalidURL
    case tokenRefreshError
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
