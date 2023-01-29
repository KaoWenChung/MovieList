//
//  AccountDIContainer.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import UIKit

final class AccountSceneDIContainer {
    // MARK: - Use Cases
    func makeLoginUseCase() -> LoginUseCaseType {
        return LoginUseCase(loginRepository: makeLoginRepository())
    }

    func makeRegisterUseCase() -> RegisterUseCaseType {
        return RegisterUseCase(registerRepository: makeRegisterRepository())
    }

    // MARK: - Login
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        LoginViewController(viewModel: makeLoginViewModel(actions: actions))
    }

    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        LoginViewModel(loginUseCase: makeLoginUseCase(), actions: actions)
    }

    // MARK: Register
    func makeRegisterViewController(actions: RegisterViewModelActions) -> RegisterViewController {
        RegisterViewController(viewModel: makeRegisterViewModel(actions: actions))
    }

    func makeRegisterViewModel(actions: RegisterViewModelActions) -> RegisterViewModel {
        RegisterViewModel(registerUseCase: makeRegisterUseCase(), actions: actions)
    }

    // MARK: - Repositories
    func makeLoginRepository() -> LoginRepositoryType {
        return FirebaseLoginRepository()
    }

    func makeRegisterRepository() -> RegisterRepositoryType {
        return FirebaseRegisterRepository()
    }
    // MARK: - Flow Coordinators
    func makeAccountFlowCoordinator(navigationController: UINavigationController) -> AccountFlowCoordinator {
        AccountFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension AccountSceneDIContainer: AccountFlowCoordinatorDependencies {}
