//
//  MoviesSearchFlowCoordinator.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import UIKit

protocol MoviesSearchFlowCoordinatorDependencies  {
    func makeMovieListViewController() -> MovieListViewController
}

final class MoviesSearchFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: MoviesSearchFlowCoordinatorDependencies

    init(navigationController: UINavigationController?,
         dependencies: MoviesSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let vc = dependencies.makeMovieListViewController()

        navigationController?.setViewControllers([vc], animated: true)
    }
}
