//
//  FirebaseLoginRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import FirebaseAuth

struct FirebaseLoginRepository {}

extension FirebaseLoginRepository: LoginRepositoryType {
    public func login(account: AccountValue, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: account.email, password: account.password) { (result, error) in
            if let user = result?.user {
                print(user)
                completion(.success(user.description))
            }
        }
    }
}
