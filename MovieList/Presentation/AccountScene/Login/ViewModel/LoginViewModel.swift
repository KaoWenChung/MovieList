//
//  LoginViewModel.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

struct LoginViewModelActions {
    let didLogin: () -> Void
    let didRigster: () -> Void
}

protocol LoginViewModelInput {
    func Login(_ account: AccountValue)
    func didSelectRigster()
}

protocol LoginViewModelOutput {
    var error: Observable<String> { get }
    var errorTitle: String { get }
}

protocol LoginViewModelType: LoginViewModelInput, LoginViewModelOutput {}

final class LoginViewModel {
    // MARK: UseCase
    private let LoginUSeCase: LoginRepositoryType
    // MARK: Actions
    private let actions: LoginViewModelActions?
    // MARK: Output
    let error: Observable<String> = Observable("")
    private(set) var errorTitle: String = ""
    init(LoginUSeCase: LoginRepositoryType,
         actions: LoginViewModelActions?) {
        self.LoginUSeCase = LoginUSeCase
        self.actions = actions
    }
    private func handle(error: Error) {
        
    }
}

extension LoginViewModel: LoginViewModelType {
    func didSelectRigster() {
        actions?.didRigster()
    }
    
    func Login(_ account: AccountValue) {
        LoginUSeCase.login(account: account) { result in
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
