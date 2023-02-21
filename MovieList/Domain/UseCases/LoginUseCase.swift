//
//  LoginUseCase.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

protocol LoginUseCaseType {
    func fetchSavedEmail() -> String?
    func login(value: LoginValue, completion: @escaping (Error?) -> Void)
    func loginByBioAuth(completion: @escaping (Error?) -> Void)
    func isBioAuthOn() -> Bool
    func isSaveEmailOn() -> Bool
}

struct LoginUseCase: LoginUseCaseType {
    private let loginRepository: LoginRepositoryType

    init(loginRepository: LoginRepositoryType) {
        self.loginRepository = loginRepository
    }

    func login(value: LoginValue, completion: @escaping (Error?) -> Void) {
        loginRepository.login(value: value, completion: completion)
    }

    func loginByBioAuth(completion: @escaping (Error?) -> Void) {
        loginRepository.fetchAccount() { result in
            switch result {
            case .success(let account):
                let loginValue = LoginValue(isEmailSaved: nil, isBioAuthOn: nil, account: account)
                self.loginRepository.login(value: loginValue, completion: completion)
            case .failure(let error):
                completion(error)
            }
        }
    }

    func fetchSavedEmail() -> String? {
        loginRepository.fetchSavedEmail()
    }

    func isBioAuthOn() -> Bool {
        loginRepository.isBioAuthOn()
    }

    func isSaveEmailOn() -> Bool {
        loginRepository.isSaveEmail()
    }
}
