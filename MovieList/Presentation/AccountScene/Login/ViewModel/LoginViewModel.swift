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
    func didSelectLogin(_ account: AccountValue)
    func didSelectRegister()
    func tryLoginByBiometricAuthentication()
}

protocol LoginViewModelOutput {
    var error: Observable<String> { get }
    var errorTitle: String { get }
    var savedAccount: String? { get }
}

protocol LoginViewModelType: LoginViewModelInput, LoginViewModelOutput {}

final class LoginViewModel {
    // MARK: UseCase
    private let loginUseCase: LoginUseCaseType
    // MARK: Actions
    private let actions: LoginViewModelActions?
    // MARK: Output
    let error: Observable<String> = Observable("")
    private(set) var savedAccount: String? = UserDefaultsHelper.shared.account
    private(set) var errorTitle: String = ""
    init(loginUseCase: LoginUseCaseType,
         actions: LoginViewModelActions?) {
        self.loginUseCase = loginUseCase
        self.actions = actions
    }
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ? ErrorString.noInternet.text : error.localizedDescription
    }
    private func login(_ account: AccountValue) {
        loginUseCase.execute(requestValue: account) { result in
            switch result {
            case .success():
                self.actions?.didLogin()
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
}

extension LoginViewModel: LoginViewModelType {
    func tryLoginByBiometricAuthentication() {
        let reason = "Authenticate to login your app"
        guard let savedAccount else { return }
        BiometricHelper.tryBiometricAuthentication(reason: reason, completion: { result in
            guard result,
            let password = KeychainHelper.readPassword(account: savedAccount) else { return }
            
            let account = AccountValue(email: savedAccount, password: password)
            self.login(account)
        })
    }
    
    func didSelectRegister() {
        actions?.didRegister()
    }
    
    func didSelectLogin(_ account: AccountValue) {
        UserDefaultsHelper.shared.account = account.email
        KeychainHelper.savePassword(account.password, account: account.email)
        login(account)
    }
}
