//
//  Endpoint.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/2/23.
//

import Foundation

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

protocol Endpoint {
    associatedtype ModelType: Decodable
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var requiresAuth: Bool { get }
    var queryItems:[String:String]? { get }
    
}

extension Endpoint {
    var url: URL {
        var components = URLComponents(string: host)!
        components.path = path
        if let cQueryItems = self.queryItems {
            let additionalQueryItems = cQueryItems.compactMap{ item in
                URLQueryItem(name: item.key, value: item.value)
            }
            if components.queryItems != nil {
                components.queryItems?.append(contentsOf:additionalQueryItems)
            } else {
                components.queryItems = additionalQueryItems
            }
        }
        return components.url!
    }
}




