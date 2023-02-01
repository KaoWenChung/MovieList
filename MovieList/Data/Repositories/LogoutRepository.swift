//
//  LogoutRepository.swift
//  MovieList
//
//  Created by wyn on 2023/2/1.
//

struct LogoutRepository {
    let userdefault: UserDefaultsHelperType
    let keychain: KeychainHelperType
    
    init(userdefault: UserDefaultsHelperType,
         keychain: KeychainHelperType) {
        self.userdefault = userdefault
        self.keychain = keychain
    }
}

extension LogoutRepository: LogoutRepositoryType {
    public func logout() {
        if let account = userdefault.readAccount() {
            keychain.removePassword(account: account)
            userdefault.removeUserData()
        }
    }
}
