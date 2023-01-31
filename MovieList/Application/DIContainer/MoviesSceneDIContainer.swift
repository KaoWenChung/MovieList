//
//  MoviesSceneDIContainer.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import UIKit

final class MoviesSceneDIContainer {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
        let imageCache: ImageCacheType
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> SearchMoviesUseCaseType {
        SearchMoviesUseCase(moviesRepository: makeMoviesRepository())
    }

    // MARK: - Movie List
    func makeMovieListViewController() -> MovieListViewController {
        MovieListViewController(viewModel: makeMovieListViewModel())
    }
    
    func makeMovieListViewModel() -> MovieListViewModelType {
        MovieListViewModel(imageRepository: makeLaunchImagesRepository(), searchMoviesUseCase: makeSearchMoviesUseCase())
    }

    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepositoryType {
        MoviesRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    func makeLaunchImagesRepository() -> ImageRepositoryType {
        ImageRepository(dataTransferService: dependencies.imageDataTransferService, imageCache: dependencies.imageCache)
    }

    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
        MoviesSearchFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {}
