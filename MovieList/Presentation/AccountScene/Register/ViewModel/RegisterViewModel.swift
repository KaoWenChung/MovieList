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
    func register(_ account: AccountValue)
}

protocol RegisterViewModelOutput {
    var error: Observable<String> { get }
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
    private(set) var errorTitle: String = ""
    init(registerUseCase: RegisterUseCaseType,
         actions: RegisterViewModelActions?) {
        self.registerUseCase = registerUseCase
        self.actions = actions
    }
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ? ErrorString.noInternet.text : error.localizedDescription
    }
}

extension RegisterViewModel: RegisterViewModelType {
    func register(_ account: AccountValue) {
        registerUseCase.execute(requestValue: account) { result in
            switch result {
            case .success():
                self.actions?.didRegister()
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
}
