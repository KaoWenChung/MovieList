//
//  RegisterUseCase.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

protocol RegisterUseCaseType {
    func execute(requestValue: AccountValue,
                 completion: @escaping (Result<String, Error>) -> Void)
}

struct RegisterUseCase: RegisterUseCaseType {
    private let registerRepository: RegisterRepositoryType

    init(registerRepository: RegisterRepositoryType) {
        self.registerRepository = registerRepository
    }
    func execute(requestValue: AccountValue, completion: @escaping (Result<String, Error>) -> Void) {
        registerRepository.register(account: requestValue, completion: completion)
    }
}

struct AccountValue {
    let email: String
    let password: String
}
