//
//  MemeImageView.swift
//  genme
//
//  Created by Emirhan Karahan on 23.09.2023.
//

import UIKit
import SkeletonView

final class MemeImageView: UIImageView {

    private var imageUrlString: String?
    
    private let imageCache = NSCache<NSString, AnyObject>()

    func loadImage(urlString: String?) async throws {
        showAnimatedGradientSkeleton()
        imageUrlString = urlString
        
        guard let urlString, let url = URL(string: urlString) else {
            throw MemeError.invalidURL
        }
        
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = imageFromCache
            hideSkeleton()
            return
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MemeError.invalidServerResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw MemeError.invalidImage
        }
        
        if imageUrlString == urlString {
            self.image = image
        }
        
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
        hideSkeleton()
    }

}
