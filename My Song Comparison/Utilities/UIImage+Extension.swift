//
//  UIImage+Extension.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/16/23.
//

import UIKit

//fileprivate let imageCache = NSCache<NSString, UIImage>()
//
//
//extension UIImageView {
//    func loadImageWithUrl(urlString: String) async throws {
//        image = nil
//        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
//            image = cachedImage
//            return
//        }
//        guard let url = URL(string: urlString) else { return }
//        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
//        guard let downloadedImage = UIImage(data: data) else { return }
//        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
//        self.image = downloadedImage
//    }
//}



extension UIImage {
    func loadImage(_ url: String) async throws -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
        guard let value = UIImage(data: data) else { return nil }
        return value
    }
}
