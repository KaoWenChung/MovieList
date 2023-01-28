//
//  AppDIContainer.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import Foundation

final class AppDIContainer {
    let appConfiguration = AppConfiguration()

    // MARK: - Network
    lazy var apiDataTransferService = {
        let config = APIDataNetworkConfigurable(baseURL: URL(string: appConfiguration.baseURL)!,
                                                queryParameters: ["apikey": appConfiguration.apiKey])
        let apiDataNetwork = NetworkService(config: config)
        return DataTransferService(networkService: apiDataNetwork)
    }()
    
    lazy var imageDataTransferService = {
        let config = APIDataNetworkConfigurable()
        let imagesDataNetwork = NetworkService(config: config)
        return DataTransferService(networkService: imagesDataNetwork)
    }()
    
    // MARK: - Cache
    let imageCache = ImageCache()

    // MARK: - DIContainers of scenes
    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
        let dependencies = MoviesSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService,
                                                               imageDataTransferService: imageDataTransferService)
        return MoviesSceneDIContainer(dependencies: dependencies)
    }
}
