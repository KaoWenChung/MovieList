//
//  ImageRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import UIKit

protocol ImageRepositoryType {
    func fetchImage(with imagePath: String, completion: @escaping (UIImage?) -> Void) -> CancellableType?
}

struct ImageRepository {
    private let dataTransferService: DataTransferServiceType
    private let imageCache: ImageCacheType

    init(dataTransferService: DataTransferServiceType,
         imageCache: ImageCacheType) {
        self.dataTransferService = dataTransferService
        self.imageCache = imageCache
    }
}

extension ImageRepository: ImageRepositoryType {
    func fetchImage(with imagePath: String, completion: @escaping (UIImage?) -> Void) -> CancellableType? {
        if let image = imageCache[imagePath] {
            completion(image)
            return nil
        }
        let endpoint = APIEndpoints.getImage(path: imagePath)
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(with: endpoint) { (result: Result<Data, DataTransferError>) in
            if case .success(let data) = result,
               let imageResult = UIImage(data: data) {
                self.imageCache.insertImage(imageResult, for: imagePath)
                completion(imageResult)
            } else {
                completion(nil)
            }
        }
        return task
    }
}
