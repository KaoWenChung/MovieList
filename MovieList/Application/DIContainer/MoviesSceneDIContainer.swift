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
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        return SearchMoviesUseCase(moviesRepository: makeMoviesRepository())
    }

    // MARK: - Movies List
    func makeMovieListViewController(actions: MovieListViewModelActions) -> MovieListViewController {
        return MovieListViewController(viewModel: makeMovieListViewModel(actions: actions))
    }
    
    func makeMovieListViewModel(actions: MovieListViewModelActions) -> MovieListViewModelType {
        return MovieListViewModel(searchMoviesUseCase: makeSearchMoviesUseCase(), actions: actions)
    }

    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepositoryType {
        return MoviesRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
        MoviesSearchFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {}
