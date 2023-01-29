//
//  RegisterRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import FirebaseAuth

struct FirebaseRegisterRepository {}

extension FirebaseRegisterRepository: RegisterRepositoryType {
    public func register(account: AccountValue, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: account.email, password: account.password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
