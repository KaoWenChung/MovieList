//
//  LoginViewModel.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

struct LoginViewModelActions {
    let didLogin: () -> Void
    let didRegister: () -> Void
}

protocol LoginViewModelInput {
    func login(_ account: AccountValue)
    func didSelectRegister()
}

protocol LoginViewModelOutput {
    var error: Observable<String> { get }
    var errorTitle: String { get }
}

protocol LoginViewModelType: LoginViewModelInput, LoginViewModelOutput {}

final class LoginViewModel {
    // MARK: UseCase
    private let loginUseCase: LoginUseCaseType
    // MARK: Actions
    private let actions: LoginViewModelActions?
    // MARK: Output
    let error: Observable<String> = Observable("")
    private(set) var errorTitle: String = ""
    init(loginUseCase: LoginUseCaseType,
         actions: LoginViewModelActions?) {
        self.loginUseCase = loginUseCase
        self.actions = actions
    }
    private func handle(error: Error) {
        
    }
}

extension LoginViewModel: LoginViewModelType {
    func didSelectRegister() {
        actions?.didRegister()
    }
    
    func login(_ account: AccountValue) {
        loginUseCase.execute(requestValue: account) { result in
            switch result {
            case .success(let value):
                self.actions?.didLogin()
                print(value)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
}
