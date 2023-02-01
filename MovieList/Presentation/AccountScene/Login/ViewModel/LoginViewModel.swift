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
    func viewDidLoad()
    func didSelectLogin(_ account: AccountValue)
    func didSelectRegister()
}

protocol LoginViewModelOutput {
    var error: Observable<String> { get }
    var status: Observable<LoadingStatus> { get }
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
    let status: Observable<LoadingStatus> = Observable(.normal)

    private(set) var savedAccount: String? = nil
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
        status.value = .loading
        loginUseCase.login(requestValue: account) { result in
            switch result {
            case .success():
                self.actions?.didLogin()
            case .failure(let error):
                self.handle(error: error)
            }
            self.status.value = .normal
        }
    }

    private func loginByBiometricAuthentication() {
        guard savedAccount != nil else { return }
        loginUseCase.loginByBiometricAuthentication() { result in
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
    func viewDidLoad() {
        savedAccount = loginUseCase.fetchSavedEmail()
        loginByBiometricAuthentication()
    }
    
    func didSelectRegister() {
        actions?.didRegister()
    }
    
    func didSelectLogin(_ account: AccountValue) {
        login(account)
    }
}
