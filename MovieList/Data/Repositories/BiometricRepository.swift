//
//  BiometryState.swift
//  MovieList
//
//  Created by wyn on 2023/1/30.
//

import LocalAuthentication

protocol BiometricRepositoryType {
    func fetchSavedEmail() -> String?
    func fetchAccount(completion: @escaping (Result<AccountValue, Error>) -> Void)
}

struct BiometricRepository {
    let userdefault: UserDefaultsHelperType
    let keychain: KeychainHelperType
    
    init(userdefault: UserDefaultsHelperType,
         keychain: KeychainHelperType) {
        self.userdefault = userdefault
        self.keychain = keychain
    }
}

extension BiometricRepository: BiometricRepositoryType {
    func fetchSavedEmail() -> String? {
        userdefault.readAccount()
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
                if authenticated {
                    guard let email = userdefault.readAccount(),
                          let password = keychain.readPassword(account: email) else { return }
                    let account = AccountValue(email: email, password: password)
                    completion(.success(account))
                }
            }
            if let error {
                completion(.failure(error))
            }
        }
    }
}
