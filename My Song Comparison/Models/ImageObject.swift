//
//  ImageObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/5/23.
//

struct ImageObject: Codable {
    var url: String
    
    private enum CodingKeys: String, CodingKey {
        case url
    }
}

extension ImageObject {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
}
