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
    func setSaveEamil(_ isOn: Bool)
    func setLoginByBio(_ isOn: Bool)
}

protocol LoginViewModelOutput {
    var error: Observable<String> { get }
    var status: Observable<LoadingStatus> { get }
    var errorTitle: String { get }
    var savedAccount: String? { get }
    var isBioLogin: Bool { get }
    var isSaveEmail: Bool { get }
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

    private(set) var isBioLogin: Bool = false
    private(set) var isSaveEmail: Bool = false
    private(set) var savedAccount: String?
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
        let loginValue = LoginValue(isEmailSaved: isSaveEmail, isBioAuthOn: isBioLogin, account: account)
        loginUseCase.login(value: loginValue) { error in
            if let error {
                self.handle(error: error)
            } else {
                self.actions?.didLogin()
            }
            self.status.value = .normal
        }
    }

    private func loginByBioAuth() {
        guard isBioLogin else { return }
        loginUseCase.loginByBioAuth { error in
            if let error {
                self.handle(error: error)
            } else {
                self.actions?.didLogin()
            }
        }
    }
}

extension LoginViewModel: LoginViewModelType {
    func viewDidLoad() {
        isBioLogin = loginUseCase.isBioAuthOn()
        isSaveEmail = loginUseCase.isSaveEmailOn()
        if isSaveEmail {
            savedAccount = loginUseCase.fetchSavedEmail()
        }
        loginByBioAuth()
    }

    func didSelectRegister() {
        actions?.didRegister()
    }

    func didSelectLogin(_ account: AccountValue) {
        login(account)
    }

    func setSaveEamil(_ isOn: Bool) {
        isSaveEmail = isOn
    }

    func setLoginByBio(_ isOn: Bool) {
        isBioLogin = isOn
    }
}
