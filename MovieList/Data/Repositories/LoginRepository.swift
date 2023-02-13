//
//  FirebaseLoginRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import FirebaseAuth

struct LoginRepository {
    let userdefault: LoginUserDefaultStorageType
    let keychain: LoginKeychainStorageType
    
    init(userdefault: LoginUserDefaultStorageType,
         keychain: LoginKeychainStorageType) {
        self.userdefault = userdefault
        self.keychain = keychain
    }
}

extension LoginRepository: LoginRepositoryType {
    public func login(value: LoginValue, completion: @escaping (Result<Void, Error>) -> Void) {
        let account = value.account
        Auth.auth().signIn(withEmail: account.email, password: account.password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if value.isEmailSaved == true || value.isBioAuthOn == true {
                    userdefault.saveEmail(account.email)
                }
                if value.isBioAuthOn == true {
                    keychain.savePassword(account.password, account: account.email)
                }
                completion(.success(()))
            }
        }
    }
}

struct LoginValue {
    let isEmailSaved: Bool?
    let isBioAuthOn: Bool?
    let account: AccountValue
}
