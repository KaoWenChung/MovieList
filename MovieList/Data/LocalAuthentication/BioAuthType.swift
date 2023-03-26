//
//  BioAuthType.swift
//  MovieList
//
//  Created by wyn on 2023/2/19.
//

import LocalAuthentication

enum BioAuthError: Error {
    case noAuthenticated
}

protocol BioAuthType {
    func authenticationWithBiometrics(completion: @escaping (Error?) -> Void)
}

struct BioAuth: BioAuthType {
    func authenticationWithBiometrics(completion: @escaping (Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        let reason = "Authenticate to login your app"
        if context.canEvaluatePolicy(
          .deviceOwnerAuthenticationWithBiometrics,
          error: &error) {
          context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason) { authenticated, error in
                guard authenticated else {
                    completion(BioAuthError.noAuthenticated)
                    return
                }
                if let error {
                    completion(error)
                    return
                }
                completion(nil)
            }
            if let error {
                completion(error)
            }
        }
    }
}
