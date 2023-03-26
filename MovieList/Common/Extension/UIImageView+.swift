//
//  UIImageView+.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import UIKit

extension UIImageView {
    /// Download image by URL
    func downloaded(imageLoader: ImageRepositoryType,
                    from url: String?,
                    placeholderImage: String = ImageContents.defaultNoImage,
                    contentMode mode: ContentMode = .scaleAspectFit,
                    completion: (() -> Void)? = nil) -> CancellableType? {
        contentMode = mode
        image = UIImage(named: placeholderImage)
        guard let url, !url.isEmpty else { return nil }
        return imageLoader.fetchImage(with: url, completion: { image in
            guard let image else { return }
            DispatchQueue.main.async {
                self.image = image
                completion?()
            }
        })
    }
}
