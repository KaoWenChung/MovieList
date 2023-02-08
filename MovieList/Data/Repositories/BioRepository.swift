//
//  BiometryState.swift
//  MovieList
//
//  Created by wyn on 2023/1/30.
//

import LocalAuthentication

protocol BioRepositoryType {
    func fetchSavedEmail() -> String?
    func fetchAccount(completion: @escaping (Result<AccountValue, Error>) -> Void)
    func isBioAuthOn() -> Bool
    func toggleBioAuth(_ isOn: Bool)
    func isSaveEmail() -> Bool
    func toggleSaveEmail(_ isOn: Bool)
}

struct BioRepository {
    let userdefault: BioRepoUserDefaultsType
    let keychain: KeychainHelperType
    
    init(userdefault: BioRepoUserDefaultsType,
         keychain: KeychainHelperType) {
        self.userdefault = userdefault
        self.keychain = keychain
    }
}

extension BioRepository: BioRepositoryType {
    func isSaveEmail() -> Bool {
        userdefault.readSaveEmail() ?? false
    }

    func toggleSaveEmail(_ isOn: Bool) {
        userdefault.toggleSaveEmail(isOn)
    }

    func isBioAuthOn() -> Bool {
        userdefault.readBioAuth() ?? false
    }

    func toggleBioAuth(_ isOn: Bool) {
        userdefault.toggleBioAuth(isOn)
    }
    
    func fetchSavedEmail() -> String? {
        userdefault.readEmail()
    }

    func fetchAccount(completion: @escaping (Result<AccountValue, Error>) -> Void) {
        let context = LAContext()
        var error: NSError?
        let reason = "Authenticate to login your app"
        if context.canEvaluatePolicy (
          .deviceOwnerAuthenticationWithBiometrics,
          error: &error) {
          context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason) { authenticated, error in
                guard authenticated,
                      let email = userdefault.readEmail(),
                      let password = keychain.readPassword(account: email) else { return }
                let account = AccountValue(email: email, password: password)
                completion(.success(account))
            }
            if let error {
                completion(.failure(error))
            }
        }
    }
}
