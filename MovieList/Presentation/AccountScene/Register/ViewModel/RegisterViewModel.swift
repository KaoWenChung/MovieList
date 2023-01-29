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
    private let registerUSeCase: RegisterRepositoryType
    // MARK: Actions
    private let actions: RegisterViewModelActions?
    // MARK: Output
    let error: Observable<String> = Observable("")
    private(set) var errorTitle: String = ""
    init(registerUSeCase: RegisterRepositoryType,
         actions: RegisterViewModelActions?) {
        self.registerUSeCase = registerUSeCase
        self.actions = actions
    }
    private func handle(error: Error) {
        
    }
}

extension RegisterViewModel: RegisterViewModelType {
    func register(_ account: AccountValue) {
        registerUSeCase.register(account: account) { result in
            switch result {
            case .success(let value):
                self.actions?.didRegister()
                print(value)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
}
