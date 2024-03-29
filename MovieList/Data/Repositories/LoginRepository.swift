//
//  Created by wyn on 2023/1/29.
//

import FirebaseAuth

enum LoginError: Error {
    case noAccountData
}

struct LoginRepository {
    let firebaseAuth: FirebaseAuthType
    let userdefault: LoginUserDefaultStorageType
    let keychain: LoginKeychainStorageType
    let bioAuth: BioAuthType

    init(firebase: FirebaseAuthType = Auth.auth(),
         userdefault: LoginUserDefaultStorageType,
         keychain: LoginKeychainStorageType,
         bioAuth: BioAuthType = BioAuth()) {
        self.firebaseAuth = firebase
        self.userdefault = userdefault
        self.keychain = keychain
        self.bioAuth = bioAuth
    }

    private func saveEmailIfNeeded(_ value: LoginValue) {
        guard value.isEmailSaved == true || value.isBioAuthOn == true else { return }
        userdefault.toggleSaveEmail(true)
        userdefault.saveEmail(value.account.email)
    }

    private func savePasswordIfNeeded(_ value: LoginValue) {
        guard value.isBioAuthOn == true else { return }
        userdefault.toggleBioAuth(true)
        let account = value.account
        keychain.savePassword(account.password, account: account.email)
    }
}

extension LoginRepository: LoginRepositoryType {
    public func login(value: LoginValue, completion: @escaping (Error?) -> Void) {
        let account = value.account
        firebaseAuth.signIn(email: account.email,
                            password: account.password) { (_, error) in
            if let error = error {
                completion(error)
            } else {
                saveEmailIfNeeded(value)
                savePasswordIfNeeded(value)
                completion(nil)
            }
        }
    }
    func isSaveEmail() -> Bool {
        userdefault.readSaveEmail() ?? false
    }

    func isBioAuthOn() -> Bool {
        userdefault.readBioAuth() ?? false
    }

    func fetchSavedEmail() -> String? {
        userdefault.readEmail()
    }

    func fetchAccount(completion: @escaping (Result<AccountValue, Error>) -> Void) {
        guard let email = userdefault.readEmail(),
              let password = keychain.readPassword(account: email) else {
                  completion(.failure(LoginError.noAccountData))
                  return
              }
        bioAuth.authenticationWithBiometrics { error in
            if let error {
                completion(.failure(error))
            }
            completion(.success(AccountValue(email: email, password: password)))
        }
    }
}

struct LoginValue {
    let isEmailSaved: Bool?
    let isBioAuthOn: Bool?
    let account: AccountValue
    init(isEmailSaved: Bool?,
         isBioAuthOn: Bool?,
         account: AccountValue) {
        self.isEmailSaved = isEmailSaved
        self.isBioAuthOn = isBioAuthOn
        self.account = account
    }
}
