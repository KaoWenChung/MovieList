//
//  RegisterRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import FirebaseAuth

struct FirebaseRegisterRepository {}

extension FirebaseRegisterRepository: RegisterRepositoryType {
    public func register(account: AccountValue, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: account.email, password: account.password) { (authResult, error) in
            if let user = authResult?.user {
                print(user)
                completion(.success(user.description))
            }
        }
    }
}
