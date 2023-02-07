//
//  LoginUseCase.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

protocol LoginUseCaseType {
    func fetchSavedEmail() -> String?
    func login(requestValue: AccountValue,
                 completion: @escaping (Result<Void, Error>) -> Void)
    func loginByBioAuth(completion: @escaping (Result<Void, Error>) -> Void)
    func isBioAuthOn() -> Bool
    func toggleBioAuth(_ isOn: Bool)
    func isSaveEmailOn() -> Bool
    func toggleSaveEmail(_ isOn: Bool)
}

struct LoginUseCase: LoginUseCaseType {
    private let bioRepository: BioRepositoryType
    private let loginRepository: LoginRepositoryType

    init(bioRepository: BioRepositoryType,
         loginRepository: LoginRepositoryType) {
        self.bioRepository = bioRepository
        self.loginRepository = loginRepository
    }

    func login(requestValue: AccountValue, completion: @escaping (Result<Void, Error>) -> Void) {
        loginRepository.login(account: requestValue, completion: completion)
    }

    func loginByBioAuth(completion: @escaping (Result<Void, Error>) -> Void) {
        bioRepository.fetchAccount() { result in
            switch result {
            case .success(let account):
                self.loginRepository.login(account: account, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchSavedEmail() -> String? {
        bioRepository.fetchSavedEmail()
    }

    func isBioAuthOn() -> Bool {
        bioRepository.isBioAuthOn()
    }

    func toggleBioAuth(_ isOn: Bool) {
        bioRepository.toggleBioAuth(isOn)
    }

    func isSaveEmailOn() -> Bool {
        bioRepository.isSaveEmail()
    }

    func toggleSaveEmail(_ isOn: Bool) {
        bioRepository.toggleSaveEmail(isOn)
    }
}
