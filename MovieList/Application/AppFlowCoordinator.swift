//
//  AppFlowCoordinator.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func startAccountScene() {
        let accountSceneDIContainer = appDIContainer.makeAccountSceneDIContainer()
        let flow = accountSceneDIContainer.makeAccountFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
    
    func startMoviesScene() {
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
// MARK: AccountFlowCoordinatorDelegate
extension AppFlowCoordinator: AccountFlowCoordinatorDelegate {
    func didLogin() {
        startMoviesScene()
    }
}
