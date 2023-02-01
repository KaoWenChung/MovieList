//
//  FirebaseLoginRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import FirebaseAuth

struct LoginRepository {
    let userdefault: UserDefaultsHelperType
    let keychain: KeychainHelperType
    
    init(userdefault: UserDefaultsHelperType,
         keychain: KeychainHelperType) {
        self.userdefault = userdefault
        self.keychain = keychain
    }
}

extension LoginRepository: LoginRepositoryType {
    public func login(account: AccountValue, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: account.email, password: account.password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                userdefault.saveAccount(account.email)
                keychain.savePassword(account.password, account: account.email)
                completion(.success(()))
            }
        }
    }
}
