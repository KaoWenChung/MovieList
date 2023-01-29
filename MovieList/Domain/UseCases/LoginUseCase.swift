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
    private let registerRepository: RegisterRepositoryType

    init(registerRepository: RegisterRepositoryType) {
        self.registerRepository = registerRepository
    }
    func execute(requestValue: AccountValue, completion: @escaping (Result<String, Error>) -> Void) {
        registerRepository.register(account: requestValue, completion: completion)
    }
}
