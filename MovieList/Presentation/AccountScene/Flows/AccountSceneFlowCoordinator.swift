//
//  AccountSceneFlowCoordinator.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import UIKit

protocol AccountFlowCoordinatorDependencies  {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
}

protocol AccountFlowCoordinatorDelegate: AnyObject {
    func didLogin()
}

final class AccountFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: AccountFlowCoordinatorDependencies
    weak var delegate: AccountFlowCoordinatorDelegate?

    init(navigationController: UINavigationController?,
         dependencies: AccountFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = LoginViewModelActions(didLogin: didLogin, didRegister: didSelectRegister)
        let vc = dependencies.makeLoginViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: true)
    }

    func didLogin() {
        delegate?.didLogin()
    }

    func didSelectRegister() {}
}
