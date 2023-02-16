//
//  Created by wyn on 2023/1/29.
//

import FirebaseAuth
import LocalAuthentication

struct LoginRepository {
    let firebase: FirebaseAuthenticationType
    let userdefault: LoginUserDefaultStorageType
    let keychain: LoginKeychainStorageType
    
    init(firebase: FirebaseAuthenticationType = Auth.auth(),
         userdefault: LoginUserDefaultStorageType,
         keychain: LoginKeychainStorageType) {
        self.firebase = firebase
        self.userdefault = userdefault
        self.keychain = keychain
    }

    private func saveEmailIfNeeded(_ value: LoginValue) {
        guard value.isEmailSaved == true || value.isBioAuthOn == true else { return }
        userdefault.saveEmail(value.account.email)
    }

    private func savePasswordIfNeeded(_ value: LoginValue) {
        guard value.isBioAuthOn == true else { return }
        let account = value.account
        keychain.savePassword(account.password, account: account.email)
    }
}

extension LoginRepository: LoginRepositoryType {
    public func login(value: LoginValue, completion: @escaping (Result<Void, Error>) -> Void) {
        let account = value.account
        firebase.signIn(email: account.email, password: account.password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                saveEmailIfNeeded(value)
                savePasswordIfNeeded(value)
                completion(.success(()))
            }
        }
    }
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

struct LoginValue {
    let isEmailSaved: Bool?
    let isBioAuthOn: Bool?
    let account: AccountValue
}
