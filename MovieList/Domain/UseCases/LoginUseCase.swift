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
    func loginByBiometricAuthentication(completion: @escaping (Result<Void, Error>) -> Void)
}

struct LoginUseCase: LoginUseCaseType {
    private let biometricRepository: BiometricRepositoryType
    private let loginRepository: LoginRepositoryType

    init(biometricRepository: BiometricRepositoryType,
         loginRepository: LoginRepositoryType) {
        self.biometricRepository = biometricRepository
        self.loginRepository = loginRepository
    }

    func login(requestValue: AccountValue, completion: @escaping (Result<Void, Error>) -> Void) {
        loginRepository.login(account: requestValue, completion: completion)
    }

    func loginByBiometricAuthentication(completion: @escaping (Result<Void, Error>) -> Void) {
        biometricRepository.fetchAccount() { result in
            switch result {
            case .success(let account):
                self.loginRepository.login(account: account, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchSavedEmail() -> String? {
        biometricRepository.fetchSavedEmail()
    }
}
