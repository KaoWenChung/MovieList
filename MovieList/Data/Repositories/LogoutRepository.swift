//
//  LogoutRepository.swift
//  MovieList
//
//  Created by wyn on 2023/2/1.
//

struct LogoutRepository {
    let userdefault: BioRepoUserDefaultsType
    let keychain: KeychainHelperType
    
    init(userdefault: BioRepoUserDefaultsType,
         keychain: KeychainHelperType) {
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
