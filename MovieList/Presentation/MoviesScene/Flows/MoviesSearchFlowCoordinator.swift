//
//  MoviesSearchFlowCoordinator.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import UIKit

protocol MoviesSearchFlowCoordinatorDependencies  {
    func makeMovieListViewController(actions: MovieListViewModelActions) -> MovieListViewController
}

protocol MoviesSearchFlowCoordinatorDelegate: AnyObject {
    func didLogout()
}

final class MoviesSearchFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: MoviesSearchFlowCoordinatorDependencies
    weak var delegate: MoviesSearchFlowCoordinatorDelegate?

    init(navigationController: UINavigationController?,
         dependencies: MoviesSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let vc = dependencies.makeMovieListViewController(actions: MovieListViewModelActions(didLogout: didLogout))

        navigationController?.setViewControllers([vc], animated: true)
    }

    private func didLogout() {
        delegate?.didLogout()
    }
}
