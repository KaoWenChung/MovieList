//
//  AccountDIContainer.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import UIKit

final class AccountSceneDIContainer {
    struct Dependencies {
        let userdefault: LoginStorageType
        let keychain: PasswordKeychainType
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases
    func makeLoginUseCase() -> LoginUseCaseType {
        LoginUseCase(bioRepository: makeBioRepository(), loginRepository: makeLoginRepository())
    }

    func makeRegisterUseCase() -> RegisterUseCaseType {
        RegisterUseCase(registerRepository: makeRegisterRepository())
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
        LoginRepository(userdefault: dependencies.userdefault, keychain: dependencies.keychain)
    }

    func makeRegisterRepository() -> RegisterRepositoryType {
        RegisterRepository(userdefault: dependencies.userdefault, keychain: dependencies.keychain)
    }

    func makeBioRepository() -> BioRepositoryType {
        BioRepository(userdefault: dependencies.userdefault, keychain: dependencies.keychain)
    }
    // MARK: - Flow Coordinators
    func makeAccountFlowCoordinator(navigationController: UINavigationController) -> AccountFlowCoordinator {
        AccountFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension AccountSceneDIContainer: AccountFlowCoordinatorDependencies {}
