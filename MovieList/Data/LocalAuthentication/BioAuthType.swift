//
//  BioAuthType.swift
//  MovieList
//
//  Created by wyn on 2023/2/19.
//

import LocalAuthentication

protocol BioAuthType {
    func authenticationWithBiometrics(email: String, password: String, completion: @escaping (Result<AccountValue, Error>) -> Void)
}

struct BioAuth: BioAuthType {
    func authenticationWithBiometrics(email: String, password: String, completion: @escaping (Result<AccountValue, Error>) -> Void) {
        let context = LAContext()
        var error: NSError?
        let reason = "Authenticate to login your app"
        if context.canEvaluatePolicy (
          .deviceOwnerAuthenticationWithBiometrics,
          error: &error) {
          context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason) { authenticated, error in
                let account = AccountValue(email: email, password: password)
                completion(.success(account))
            }
            if let error {
                completion(.failure(error))
            }
        }
    }
}
