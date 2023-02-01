//
//  RegisterViewModel.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

struct RegisterViewModelActions {
    let didRegister: () -> Void
}

protocol RegisterViewModelInput {
    func didSelectRegister(_ account: AccountValue)
}

protocol RegisterViewModelOutput {
    var error: Observable<String> { get }
    var status: Observable<LoadingStatus> { get }
    var errorTitle: String { get }
}

protocol RegisterViewModelType: RegisterViewModelInput, RegisterViewModelOutput {}

final class RegisterViewModel {
    // MARK: UseCase
    private let registerUseCase: RegisterUseCaseType
    // MARK: Actions
    private let actions: RegisterViewModelActions?
    // MARK: Output
    let error: Observable<String> = Observable("")
    let status: Observable<LoadingStatus> = Observable(.normal)
    private(set) var errorTitle: String = ""
    init(registerUseCase: RegisterUseCaseType,
         actions: RegisterViewModelActions?) {
        self.registerUseCase = registerUseCase
        self.actions = actions
    }
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ? ErrorString.noInternet.text : error.localizedDescription
    }
    private func register(_ account: AccountValue) {
        status.value = .loading
        registerUseCase.execute(requestValue: account) { result in
            switch result {
            case .success():
                self.actions?.didRegister()
            case .failure(let error):
                self.handle(error: error)
            }
            self.status.value = .normal
        }
    }
}

extension RegisterViewModel: RegisterViewModelType {
    func didSelectRegister(_ account: AccountValue) {
        UserDefaultsHelper.shared.account = account.email
        KeychainHelper.savePassword(account.password, account: account.email)
        register(account)
    }
}
