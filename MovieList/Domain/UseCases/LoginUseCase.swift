//
//  LoginUseCase.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

protocol LoginUseCaseType {
    func fetchSavedEmail() -> String?
    func login(value: LoginValue,
               completion: @escaping (Result<Void, Error>) -> Void)
    func loginByBioAuth(completion: @escaping (Result<Void, Error>) -> Void)
    func isBioAuthOn() -> Bool
    func toggleBioAuth(_ isOn: Bool)
    func isSaveEmailOn() -> Bool
    func toggleSaveEmail(_ isOn: Bool)
}

struct LoginUseCase: LoginUseCaseType {
    private let loginRepository: LoginRepositoryType

    init(loginRepository: LoginRepositoryType) {
        self.loginRepository = loginRepository
    }

    func login(value: LoginValue, completion: @escaping (Result<Void, Error>) -> Void) {
        loginRepository.login(value: value, completion: completion)
    }

    func loginByBioAuth(completion: @escaping (Result<Void, Error>) -> Void) {
        loginRepository.fetchAccount() { result in
            switch result {
            case .success(let account):
                let loginValue = LoginValue(isEmailSaved: nil, isBioAuthOn: nil, account: account)
                self.loginRepository.login(value: loginValue, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchSavedEmail() -> String? {
        loginRepository.fetchSavedEmail()
    }

    func isBioAuthOn() -> Bool {
        loginRepository.isBioAuthOn()
    }

    func toggleBioAuth(_ isOn: Bool) {
        loginRepository.toggleBioAuth(isOn)
    }

    func isSaveEmailOn() -> Bool {
        loginRepository.isSaveEmail()
    }

    func toggleSaveEmail(_ isOn: Bool) {
        loginRepository.toggleSaveEmail(isOn)
    }
}
