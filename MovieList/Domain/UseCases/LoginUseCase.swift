//
//  LoginUseCase.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

protocol LoginUseCaseType {
    func execute(requestValue: AccountValue,
                 completion: @escaping (Result<String, Error>) -> Void)
}

final class LoginUseCase: LoginUseCaseType {
    private let loginRepository: LoginRepositoryType

    init(loginRepository: LoginRepositoryType) {
        self.loginRepository = loginRepository
    }
    func execute(requestValue: AccountValue, completion: @escaping (Result<String, Error>) -> Void) {
        loginRepository.login(account: requestValue, completion: completion)
    }
}
