//
//  ImageRepositoryMock.swift
//  MovieListTests
//
//  Created by wyn on 2023/1/31.
//

@testable import MovieList
import UIKit

final class ImageRepositoryMock: ImageRepositoryType {
    func fetchImage(with imagePath: String, completion: @escaping (UIImage?) -> Void) -> CancellableType? {
        return nil
    }
}
