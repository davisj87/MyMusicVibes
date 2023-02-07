//
//  UIImage+Extension.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/16/23.
//

import UIKit

extension UIImage {
    func loadImage(_ url: String) async throws -> UIImage? {
        guard url != "" else { return nil }
        guard let url = URL(string: url) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
        guard let value = UIImage(data: data) else { return nil }
        return value
    }
}
