//
//  BiometryState.swift
//  MovieList
//
//  Created by wyn on 2023/1/30.
//

import LocalAuthentication

final class BiometricHelper {
    private init() {}
    class func tryBiometricAuthentication(reason: String, completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy (
          .deviceOwnerAuthenticationWithBiometrics,
          error: &error) {
          context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason) { authenticated, error in
                if authenticated {
                    completion(true)
                } else {
                    if let errorString = error?.localizedDescription {
                        print("Error in biometric policy evaluation: \(errorString)")
                    }
                    completion(false)
                }
            }
        } else {
            if let errorString = error?.localizedDescription {
                print("Error in biometric policy evaluation: \(errorString)")
            }
            completion(false)
        }
    }
}
