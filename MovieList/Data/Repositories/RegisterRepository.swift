//
//  RegisterRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import FirebaseAuth

struct RegisterRepository {
    let userdefault: BioRepoUserDefaultsType
    let keychain: KeychainHelperType
    
    init(userdefault: BioRepoUserDefaultsType,
         keychain: KeychainHelperType) {
        self.userdefault = userdefault
        self.keychain = keychain
    }
}

extension RegisterRepository: RegisterRepositoryType {
    public func register(account: AccountValue, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: account.email, password: account.password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                userdefault.saveEmail(account.email)
                keychain.savePassword(account.password, account: account.email)
                completion(.success(()))
            }
        }
    }
}
