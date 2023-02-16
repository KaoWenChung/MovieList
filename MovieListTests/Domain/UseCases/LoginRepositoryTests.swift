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

    class LoginRepositoryMock: LoginRepositoryType {
        var email: String?
        var accountResult: Result<AccountValue, Error>?
        var bioAuthOn: Bool
        var saveEmail: Bool
        var loginError: Error?

        init(email: String? = nil,
             accountResult: Result<AccountValue, Error>? = nil,
             bioAuthOn: Bool = false,
             saveEmail: Bool = false,
             loginError: Error?) {
            self.email = email
            self.accountResult = accountResult
            self.bioAuthOn = bioAuthOn
            self.saveEmail = saveEmail
            self.loginError = loginError
        }

        func login(value: LoginValue, completion: @escaping (Error?) -> Void) {
            completion(loginError)
        }

        func fetchSavedEmail() -> String? {
            email
        }
        
        func fetchAccount(completion: @escaping (Result<AccountValue, Error>) -> Void) {
            guard let accountResult else {
                completion(.failure(LoginErrorMock.someError))
                return
            }
            completion(accountResult)
        }
        
        func isBioAuthOn() -> Bool {
            bioAuthOn
        }
        
        func toggleBioAuth(_ isOn: Bool) {
            bioAuthOn = isOn
        }
        
        func isSaveEmail() -> Bool {
            saveEmail
        }
        
        func toggleSaveEmail(_ isOn: Bool) {
            saveEmail = isOn
        }
    }

    func test_loginSuccessfully() {
        // give
        let expectation = self.expectation(description: "Login successfully")
        let account = AccountValue(email: "test@gmail.com", password: "testPassword")
        let loginRepository = LoginRepositoryMock(loginError: nil)
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

    func test_loginFailed() {
        // give
        let expectation = self.expectation(description: "Should throw login error")
        let account = AccountValue(email: "test@gmail.com", password: "testPassword")
        let loginRepo = LoginRepositoryMock(loginError: LoginErrorMock.loginFail)
        let sut = LoginUseCase(loginRepository: loginRepo)
        // when
        let value = LoginValue(isEmailSaved: false, isBioAuthOn: false, account: account)
        sut.login(value: value, completion: { error in
            if let error = error as? LoginErrorMock,
               error == LoginErrorMock.loginFail {
                expectation.fulfill()
            } else {
                XCTFail("Should not happen")
            }
        })
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
}
