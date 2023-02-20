//
//  Created by wyn on 2023/2/15.
//

import XCTest
@testable import MovieList

final class LoginUseCaseTests: XCTestCase {
    private enum LoginErrorMock: Error, Equatable {
        case someError
        case loginFail
    }

    class FirebaseAuthMock: FirebaseAuthType {
        private(set) var isLogout: Bool = false
        var expectation: XCTestExpectation?
        var error: Error?
        var result: FirebaseAuthDataResultType?
        
        func signOut() throws {
            isLogout = true
        }
        
        func signIn(email: String, password: String, completion: ((FirebaseAuthDataResultType?, Error?) -> Void)?) {
            completion?(result, error)
        }
        
        func createUser(email: String, password: String, completion: ((FirebaseAuthDataResultType?, Error?) -> Void)?) {
            completion?(result, error)
        }
    }

    class LoginUserDefaultStorageMock: LoginUserDefaultStorageType {
        private(set) var isBioAuth: Bool = false
        private(set) var isSaveEmail: Bool = false
        private(set) var email: String?
        func toggleBioAuth(_ isOn: Bool) {
            isBioAuth = isOn
        }
        
        func readBioAuth() -> Bool? {
            isBioAuth
        }
        
        func saveEmail(_ newValue: String) {
            email = newValue
        }
        
        func readEmail() -> String? {
            email
        }
        
        func toggleSaveEmail(_ isOn: Bool) {
            isSaveEmail = isOn
        }
        
        func readSaveEmail() -> Bool? {
            isSaveEmail
        }
        
        func removeUserData() {
            isBioAuth = false
            isSaveEmail = false
            email = nil
        }
    }

    class LoginKeychainStorageMock: LoginKeychainStorageType {
        private(set) var accountDic: [String: String] = [:]
        func savePassword(_ password: String, account: String) {
            accountDic[account] = password
        }
        
        func readPassword(account: String) -> String? {
            accountDic[account]
        }
        
        func removePassword(account: String) {
            accountDic[account] = nil
        }
    }

    struct BioAuthMock: BioAuthType {
        let error: Error?
        init(error: Error? = nil) {
            self.error = error
        }
        func authenticationWithBiometrics(completion: @escaping (Error?) -> Void) {
            completion(error)
        }
    }

    func test_loginSuccessfully() {
        // give
        let expectation = self.expectation(description: "Login successfully")
        let account = AccountValue(email: "test@gmail.com", password: "testPassword")
        let loginRepository = LoginRepository(firebase: FirebaseAuthMock(), userdefault: LoginUserDefaultStorageMock(), keychain: LoginKeychainStorageMock(), bioAuth: BioAuthMock())
        let sut = LoginUseCase(loginRepository: loginRepository)
        // when
        let value = LoginValue(isEmailSaved: false, isBioAuthOn: false, account: account)
        sut.login(value: value, completion: { error in
            guard error == nil else {
                XCTFail("Should not happen")
                return
            }
            expectation.fulfill()
        })
        // Then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_loginWithEmailSavedSuccessfully_isSaveEmailOnReturnTrue() {
        // give
        let expectation = self.expectation(description: "Login and save email successfully")
        let account = AccountValue(email: "test@gmail.com", password: "testPassword")
        let userDefault = LoginUserDefaultStorageMock()
        let loginRepository = LoginRepository(firebase: FirebaseAuthMock(), userdefault: userDefault, keychain: LoginKeychainStorageMock(), bioAuth: BioAuthMock())
        let sut = LoginUseCase(loginRepository: loginRepository)
        // when
//        userDefault.toggleSaveEmail(false)
        let value = LoginValue(isEmailSaved: true, isBioAuthOn: false, account: account)
        sut.login(value: value, completion: { error in
            guard error == nil else {
                XCTFail("Should not happen")
                return
            }
            guard sut.isSaveEmailOn() else {
                XCTFail("Should not happen")
                return
            }
            expectation.fulfill()
        })
        // Then
        wait(for: [expectation], timeout: 0.1)
    }

//    func test_loginWithBioAuthSuccessfully_isBioAuthOnReturnTrue() {
//        // give
//        let expectation = self.expectation(description: "Login and save email successfully")
//        let account = AccountValue(email: "test@gmail.com", password: "testPassword")
//        let loginRepository = LoginRepositoryMock(bioAuthOn: false, loginError: nil)
//        let sut = LoginUseCase(loginRepository: loginRepository)
//        // when
//        let value = LoginValue(isEmailSaved: false, isBioAuthOn: true, account: account)
//        sut.login(value: value, completion: { error in
//            guard error == nil else {
//                XCTFail("Should not happen")
//                return
//            }
//            guard sut.isBioAuthOn() else {
//                XCTFail("Should not happen")
//                return
//            }
//            expectation.fulfill()
//        })
//        // Then
//        wait(for: [expectation], timeout: 0.1)
//    }

//    func test_loginFailed() {
//        // give
//        let expectation = self.expectation(description: "Should throw login error")
//        let account = AccountValue(email: "test@gmail.com", password: "testPassword")
//        let loginRepo = LoginRepositoryMock(loginError: LoginErrorMock.loginFail)
//        let sut = LoginUseCase(loginRepository: loginRepo)
//        // when
//        let value = LoginValue(isEmailSaved: false, isBioAuthOn: false, account: account)
//        sut.login(value: value, completion: { error in
//            if let error = error as? LoginErrorMock,
//               error == LoginErrorMock.loginFail {
//                expectation.fulfill()
//            } else {
//                XCTFail("Should not happen")
//            }
//        })
//        // Then
//        wait(for: [expectation], timeout: 0.1)
//    }
}
