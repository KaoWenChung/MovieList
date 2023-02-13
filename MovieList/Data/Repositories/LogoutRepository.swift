//
//  LogoutRepository.swift
//  MovieList
//
//  Created by wyn on 2023/2/1.
//

struct LogoutRepository {
    let userdefault: LoginUserDefaultStorageType
    let keychain: LoginKeychainStorageType
    
    init(userdefault: LoginUserDefaultStorageType,
         keychain: LoginKeychainStorageType) {
        self.userdefault = userdefault
        self.keychain = keychain
    }
}

extension LogoutRepository: LogoutRepositoryType {
    public func logout() {
        if let account = userdefault.readEmail() {
            keychain.removePassword(account: account)
            userdefault.removeUserData()
        }
    }
}
