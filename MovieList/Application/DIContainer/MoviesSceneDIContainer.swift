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
        let userdefault: UserDefaultsHelperType
        let keychain: KeychainHelperType
        let imageCache: ImageCacheType
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases
    func makeFetchMoviesUseCase() -> FetchMoviesUseCaseType {
        FetchMoviesUseCase(moviesRepository: makeMoviesRepository())
    }

    func makeLogoutUseCase() -> LogoutUseCaseType {
        return LogoutUseCase(logoutRepository: makeLogoutRepository())
    }

    // MARK: - Movie List
    func makeMovieListViewController(actions: MovieListViewModelActions) -> MovieListViewController {
        MovieListViewController(viewModel: makeMovieListViewModel(actions: actions))
    }
    
    func makeMovieListViewModel(actions: MovieListViewModelActions) -> MovieListViewModelType {
        MovieListViewModel(imageRepository: makeImagesRepository(),
                           fetchMoviesUseCase: makeFetchMoviesUseCase(),
                           actions: actions,
                           logoutUseCase: makeLogoutUseCase())
    }

    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepositoryType {
        MoviesRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    func makeImagesRepository() -> ImageRepositoryType {
        ImageRepository(dataTransferService: dependencies.imageDataTransferService, imageCache: dependencies.imageCache)
    }

    func makeLogoutRepository() -> LogoutRepositoryType {
        LogoutRepository(userdefault: dependencies.userdefault, keychain: dependencies.keychain)
    }

    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
        MoviesSearchFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {}
