//
//  MockableAPI.swift
//  My Song ComparisonTests
//
//  Created by Jarred Davis on 2/20/23.
//

import Foundation

protocol MockableAPI: AnyObject {
    var bundle: Bundle {get}
    func loadJSON<T:Decodable>(filename:String, type:T.Type) -> T?
}

extension MockableAPI {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T:Decodable>(filename:String, type:T.Type) -> T? {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load json file")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObj = try JSONDecoder().decode(T.self, from: data)
            return decodedObj
        } catch {
            print("Failed to decode json")
            return nil
        }
    }
}
