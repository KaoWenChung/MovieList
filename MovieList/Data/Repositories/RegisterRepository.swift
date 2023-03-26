//
//  RegisterRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import FirebaseAuth

struct RegisterRepository {
    let firebase: FirebaseAuthType
    let userdefault: LoginUserDefaultStorageType
    let keychain: LoginKeychainStorageType

    init(firebase: FirebaseAuthType = Auth.auth(),
         userdefault: LoginUserDefaultStorageType,
         keychain: LoginKeychainStorageType) {
        self.firebase = firebase
        self.userdefault = userdefault
        self.keychain = keychain
    }
}

extension RegisterRepository: RegisterRepositoryType {
    public func register(account: AccountValue, completion: @escaping (Error?) -> Void) {
        firebase.createUser(email: account.email, password: account.password) { (_, error) in
            if let error {
                completion(error)
            } else {
                userdefault.saveEmail(account.email)
                keychain.savePassword(account.password, account: account.email)
                completion(nil)
            }
        }
    }
}
