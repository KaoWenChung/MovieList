//
//  LogoutRepository.swift
//  MovieList
//
//  Created by wyn on 2023/2/1.
//

import FirebaseAuth

struct LogoutRepository {
    let userdefault: LoginUserDefaultStorageType
    let keychain: LoginKeychainStorageType
    let firebase: FirebaseAuthType

    init(firebase: FirebaseAuthType = Auth.auth(),
         userdefault: LoginUserDefaultStorageType,
         keychain: LoginKeychainStorageType) {
        self.firebase = firebase
        self.userdefault = userdefault
        self.keychain = keychain
    }
}

extension LogoutRepository: LogoutRepositoryType {
    public func logout() {
        if let account = userdefault.readEmail() {
            keychain.removePassword(account: account)
            userdefault.removeUserData()
            try? firebase.signOut()
        }
    }
}
